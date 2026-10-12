CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_SPANNE_WB_L_HERKUNFT_2
 (
 spanne_wb_herkunft_id,
 spanne_wb_bez
 )
 AS
    SELECT
    spr_id AS spanne_wb_herkunft_id,
    CASE
    WHEN spanne_wb_herkunft_id =1
    THEN  'Umlagerung_2 VZ => VZ oder Lieferant => Markt                            '

    WHEN spanne_wb_herkunft_id =2
    THEN  'Dezentral Lieferant => VZ/Markt sowie Umlagerung_2 Markt => Markt'

    WHEN spanne_wb_herkunft_id =3
    THEN  'Zentral VZ => Markt ("Faktura")'
    END                 AS spanne_wb_herkunft_bez
    FROM dbp_view.v_spr_2
    WHERE spr_id IN ( 1,2,3);