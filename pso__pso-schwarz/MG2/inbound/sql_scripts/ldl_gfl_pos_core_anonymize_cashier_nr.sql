--T_PAYMENT_LINE
UPDATE core_rel.t_payment_line
SET cashier_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_RETAIL_EVENT
UPDATE core_rel.t_retail_event
SET cashier_nr = '-1', auth_by_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_TAX_LINE
UPDATE core_rel.t_tax_line
SET cashier_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_SUBTOTAL_LINE
UPDATE core_rel.t_subtotal_line
SET cashier_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_PRODUCT_RETAIL_LINE
UPDATE core_rel.t_product_retail_line
SET cashier_nr = '-1', auth_by_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_PRICE_INFORMATION_EVENT
UPDATE core_rel.t_price_information_event
SET cashier_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_CANCELLATION_LINE
UPDATE core_rel.t_cancellation_line
SET cashier_nr = '-1', auth_by_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_DISCOUNT_LINE
UPDATE core_rel.t_discount_line
SET cashier_nr = '-1', auth_by_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

--T_TECHNICAL_CASH_REGISTER_EVENT
UPDATE core_rel.t_technical_cash_register_event
SET cashier_nr = '-1', dwh_updated_tmsp = CURRENT_DATE
WHERE cashier_nr<>'-1' AND bus_dt < DATEADD(week,-(${SQL_INPUT_1}),CURRENT_DATE);

