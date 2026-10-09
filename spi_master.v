
module spi_master #(
    parameter CLK_DIV = 4
)(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [7:0] tx_data,
    output reg [7:0] rx_data,
    output reg busy,
    output reg done,
    output reg sclk,
    output reg mosi,
    input wire miso,
    output reg cs_n
);

    reg [7:0] tx_shift;
    reg [7:0] rx_shift;
    reg [3:0] bit_count;
    reg [31:0] clk_count;
    reg sample_phase;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_data <= 8'b0;
            tx_shift <= 8'b0;
            rx_shift <= 8'b0;
            bit_count <= 0;
            clk_count <= 0;
            sample_phase <= 0;
            busy <= 0;
            done <= 0;
            sclk <= 0;
            mosi <= 0;
            cs_n <= 1;
        end else begin
            done <= 0;

            if (!busy) begin
                sclk <= 0;
                cs_n <= 1;
                clk_count <= 0;

                if (start) begin
                    tx_shift <= tx_data;
                    rx_shift <= 0;
                    bit_count <= 0;
                    sample_phase <= 0;
                    busy <= 1;
                    cs_n <= 0;
                    mosi <= tx_data[7];
                end
            end else begin
                if (clk_count == CLK_DIV - 1) begin
                    clk_count <= 0;
                    sclk <= ~sclk;

                    if (!sclk) begin
                        rx_shift <= {rx_shift[6:0], miso};
                        sample_phase <= 1;
                    end else begin
                        sample_phase <= 0;

                        if (bit_count == 7) begin
                            rx_data <= rx_shift;
                            busy <= 0;
                            done <= 1;
                            cs_n <= 1;
                            sclk <= 0;
                        end else begin
                            bit_count <= bit_count + 1'b1;
                            tx_shift <= {tx_shift[6:0], 1'b0};
                            mosi <= tx_shift[6];
                        end
                    end
                end else begin
                    clk_count <= clk_count + 1'b1;
                end
            end
        end
    end

endmodule
