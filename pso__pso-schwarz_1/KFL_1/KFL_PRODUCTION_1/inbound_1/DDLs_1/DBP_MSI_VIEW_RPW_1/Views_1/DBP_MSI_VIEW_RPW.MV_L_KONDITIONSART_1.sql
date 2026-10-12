CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_KONDITIONSART_1
 -- 20101130 K.Kaiser -- UNION ALL
 (
 system_id
 ,mandant_id
 ,konditionsart_id
 )
 AS

    SELECT
    7,
    mandant_id,
    konditionsart_id
    FROM dbp_view.v_l_konditionsart_1
    WHERE mandant_id = 1

 --UNION ALL

 --SELECT
 --  7 AS system_id
 --  ,1 AS mandant_id
 -- ,'0' AS konditionsart_id
 --FROM dbp_view.v_l_konditionsart_1
 --GROUP BY 1,2,3
 ;