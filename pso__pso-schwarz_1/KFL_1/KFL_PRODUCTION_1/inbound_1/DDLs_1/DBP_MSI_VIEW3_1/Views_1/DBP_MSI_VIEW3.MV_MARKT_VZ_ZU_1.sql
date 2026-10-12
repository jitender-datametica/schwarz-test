CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_MARKT_VZ_ZU_1
(
	MANDANT_ID,
	VZ_WUP_ID,
	NB_VZ_WUP_ID,
	WUP_ID,
	NB_WUP_ID,
	ENTFERNUNG,
	DIREKTE_ZUORDNUNG_FG
) AS
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
   SELECT
   v01.mandant_id, v01.vz_wup_id, -111 AS nb_vz_wup_id, 
   --wup_id,
   aktuell_wup_id ,0 AS nb_wup_id, v01.entfernung, v01.direkte_zuordnung_fg
   FROM dbp_view.v_markt_vz_zu_1 v01

INNER JOIN dbp_view.v_wup_1 v02
   ON v02.mandant_id = v01.mandant_id 
   AND v02.wup_id = v01.wup_id
   AND ((v02.nb_id IN (2, 0, -111) AND v02.wup_id > 0) OR (v02.nb_id = -1 AND v02.wup_id = 0))

   UNION

   SELECT
   v01.mandant_id, v01.vz_wup_id, -111 AS nb_vz_wup_id, 
   --wup_id,
   aktuell_wup_id ,0 AS nb_wup_id, v01.entfernung, 0 AS direkte_zuordnung_fg
   FROM dbp_view.v_markt_vz_zu_1 v01

INNER JOIN dbp_view.v_wup_1 v02
   ON v02.mandant_id = v01.mandant_id 
   AND v02.wup_id = v01.wup_id
   AND ((v02.nb_id IN (2, 0, -111) AND v02.wup_id > 0) OR (v02.nb_id = -1 AND v02.wup_id = 0))

WHERE direkte_zuordnung_fg = 1;