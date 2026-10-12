CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WUG_SPR_ZU_RO
(
mandant_id
, PRDHA
, MATKL
, spr_id
, wug_bez
, wg_wug_id_bez
)
AS
   SELECT
   v01.mandant_id, v01.wug_id AS PRDHA, 
   v01.wg_id AS MATKL, v01.spr_id, v01.wug_bez, 
   (to_char(V01.WG_ID,'FM000') || ' ' || to_char(V01.WUG_ID,'FM000') || V01.WUG_BEZ) :: Varchar(100)  WG_WUG_ID_BEZ

   FROM dbp_view.v_wug_spr_zu v01

   WHERE v01.spr_id = 95
   AND v01.arthiertyp_id = 2;