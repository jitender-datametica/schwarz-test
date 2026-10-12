CREATE OR REPLACE VIEW DBP_VIEW.V_L_CLEAR_STOCK AS 
    SELECT 
        mandant_id
        ,clear_stock_id
        ,clear_stock_bez


FROM DBP_DATA.l_clear_stock ;