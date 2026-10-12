CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_HGP
 (
 hgp_id
 ,hgp_name
 ,mandant_id
 , system_id
 ,zek_id
 ,loesch_fg
 ,gp_branche_id
 )
 AS
    SELECT
    gp_id,
    CASE WHEN loesch_fg = 1
    THEN  '{' || gp_name  || '}'
    ELSE  gp_name
    END AS gp_name,
    mandant_id,
    7,
    zek_id,
    COALESCE (loesch_fg, 0) AS loesch_fg,
    gp_branche_id
    FROM dbp_view.v_gp
    WHERE mandant_id = 1
    AND  (gp_id > 99999 AND gp_id < 1000000) OR gp_id BETWEEN 9211 AND 9220;