CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_cd_typ_spr_zu (mandant_id, cd_typ_id, spr_id, cd_typ_bez) AS
SELECT mandant_id,
 cd_typ_id,
 spr_id,
 cd_typ_bez
FROM (SELECT mandant_id,
    cd_typ_id,
    spr_id,
    cd_typ_bez
   FROM kfl_production_dbp_view.v_cd_typ_spr_zu AS V01
   UNION DISTINCT
   SELECT V01.mandant_id,
    '-1' AS cd_typ_id,
    V02.spr_id,
    'DWH - no CD Type'
   FROM kfl_production_dbp_view.v_mandant AS V01
    INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu AS V02 ON TRUE) AS t01;