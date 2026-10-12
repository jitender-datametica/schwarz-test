CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TECHN_PLATZ_SPR_ZU_PER_2(
	TECHN_PLATZ_ID,
	MANDANT_ID,
	SPR_ID,
	DAT_VON,
	DAT_BIS,
	TECH_PLATZ_BEZ
) AS
--2023-05-05, AP0133256_SPEC0166769, dknop, initial
--2023-07-17, staeblern Umstellen auf Session Variable 
  SELECT
  v01.techn_platz_id, v03.mandant_id, v01.spr_id, v01.dat_von, v01.dat_bis, v01.tech_platz_bez

   FROM dbp_view.v_techn_platz_spr_zu_per_2 v01

   JOIN  DBP_MSI_VIEW_LOG.MV_USER_SPR_ZU_2 v02
   ON v01.spr_id = v02.spr_id
   JOIN dbp_view.v_mandant_2 v03
   WHERE v01.dat_bis = '9999-12-31'
   ;