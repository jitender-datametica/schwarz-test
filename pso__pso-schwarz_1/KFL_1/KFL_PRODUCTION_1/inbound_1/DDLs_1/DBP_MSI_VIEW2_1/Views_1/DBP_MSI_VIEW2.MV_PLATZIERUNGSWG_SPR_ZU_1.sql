CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_PLATZIERUNGSWG_SPR_ZU_1
(mandant_id
,platzierungswg_id
,platzierungswg_nr
,spr_id
,platzierungswg_bez
)
AS
   SELECT
  a10.mandant_id, a10.platzierungswg_id, platzierungswg_nr, spr_id, platzierungswg_bez
   FROM dbp_view.v_platzierungswg_spr_zu_1 a10, dbp_view.v_l_platzierungswg_1 a11

   WHERE a10.mandant_id = a11.mandant_id
   AND a10.platzierungswg_id = a11.platzierungswg_id
   AND a10.mandant_id = 1
   AND spr_id = 22;