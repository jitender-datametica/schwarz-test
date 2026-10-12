CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_VAUS_WUP
(
	MANDANT_ID,
	NB_ID,
	LAND_ID,
	WUP_ID,
	BUCHUNGSKREIS_ID,
	GLN_ID
)
AS
   SELECT
   v01.mandant_id, 
   v01.nb_id, 
   v01.land_id, 
   v01.wup_id, 
   v01.buchungskreis_id, 
   v02.gln_id

   FROM dbp_view.v_wup  v01
   LEFT JOIN dbp_view.v_vaus_wup  v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   WHERE
   -- Filterung der IWT Betriebe
   v01.nb_id <> 99
   -- Filterung von Zentralfilialen
   AND NOT v01.wup_id BETWEEN 1 AND 999;
