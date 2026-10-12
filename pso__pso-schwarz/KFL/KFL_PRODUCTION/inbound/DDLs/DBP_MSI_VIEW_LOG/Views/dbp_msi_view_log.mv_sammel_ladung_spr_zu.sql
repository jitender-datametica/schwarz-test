CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_SAMMEL_LADUNG_SPR_ZU(
	SAMMEL_LADUNG_FG,
	SAMMEL_LADUNG_BEZ
) AS
--2022-06-28,AP0112140,SPEC0155506,  dknop, initial
   SELECT 
   v01.sammel_ladung_fg, 
   v01.sammel_ladung_bez
   FROM dbp_view.v_sammel_ladung_spr_zu v01
   GROUP BY v01.sammel_ladung_fg,
   v01.sammel_ladung_bez
   ;