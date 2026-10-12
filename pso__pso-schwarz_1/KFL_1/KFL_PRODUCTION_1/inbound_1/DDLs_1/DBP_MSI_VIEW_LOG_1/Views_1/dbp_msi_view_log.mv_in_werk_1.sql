CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_WERK_1(
	MANDANT_ID,
	WERK_ID,
	WERK_NR,
	WERK_NAME,
	SYSTEM_ID,
	SAKO_FG,
	BUCHUNGSKREIS_ID
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial
   SELECT
   mandant_id
  ,werk_id
  ,werk_nr
  ,werk_name
  ,system_id
  ,sako_fg
  ,buchungskreis_id
   FROM dbp_view.v_in_werk_1
;