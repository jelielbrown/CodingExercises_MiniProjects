-- Author: Jeliel Brown
-- Date: 12/09/25

CREATE PROCEDURE customer_payment_stats (
    IN p_customer_number INT,
    OUT p_payment_count INT,
    OUT p_total_amount DECIMAL(10, 2),
    OUT p_avg_amount DECIMAL(10, 2)
)
BEGIN
    SELECT Count(amount), SUM(amount), AVG(amount)
    INTO p_payment_count, p_total_amount, p_avg_amount
    FROM PAYMENT
    WHERE customer_number = p_customer_number;
    IF p_payment_count IS NULL OR p_payment_count = 0 THEN
        SET p_payment_count = 0;
        SET p_total_amount = 0.00;
        SET p_avg_amount = 0.00;
    END IF;
END;

CALL customer_payment_stats(99, @count_99, @total_99, @avg_99);
CALL customer_payment_stats(103, @count_103, @total_103, @avg_103);

SELECT 99 AS customer_number, @count_99 AS payment_count, ROUND(@total_99) AS total_amount, ROUND(avg_99) AS avg_amount;
SELECT 103 AS customer_number, @count_103 AS payment_count, ROUND(@total_103) AS total_amount, ROUND(avg_103) AS avg_amount;
