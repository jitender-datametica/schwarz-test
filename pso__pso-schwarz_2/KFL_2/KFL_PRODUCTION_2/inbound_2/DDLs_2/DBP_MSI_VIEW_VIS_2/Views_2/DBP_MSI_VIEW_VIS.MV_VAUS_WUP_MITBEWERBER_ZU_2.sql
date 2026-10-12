create or replace view DBP_MSI_VIEW_VIS.MV_VAUS_WUP_MITBEWERBER_ZU_2(
	MANDANT_ID,
	NB_ID,
	LAND_ID,
	WUP_ID,
	MITBEWERBER_ID,
	WEITERE_MITBEWERBER_ID,
	MITBEWERBER_BEZ,
	WEITERE_MITBEWERBER_BEZ
) as
   SELECT
   t01.mandant_id, t01.nb_id, t01.land_id, t01.wup_id, t01.prio_1_mitbewerber_id AS mitbewerber_id, (t01.prio_2_mitbewerber_id *100)+ t01.prio_10_mitbewerber_id AS weitere_mitbewerber_id, COALESCE(t01.prio_1_mitb,'') AS mitbewerber_bez, CASE WHEN  prio_2_mitb =  prio_10_mitb THEN prio_2_mitb
   ELSE COALESCE(prio_2_mitb,'') || (CASE WHEN prio_2_mitb IS NULL OR prio_10_mitb IS NULL THEN '' ELSE ', ' END)|| COALESCE(prio_10_mitb,'') END AS weitere_mitbewerber_bez
   FROM
   (
   SELECT
   v01.mandant_id, v01.nb_id, v01.land_id, v01.wup_id, MAX(
   CASE  WHEN v02.mitbewerber_prio = 1 THEN v03.mitbewerber_bez
   END ) prio_1_mitb, MAX(
   CASE  WHEN v02.mitbewerber_prio = 1 THEN v03.mitbewerber_id
   END ) prio_1_mitbewerber_id, MAX(
   CASE  WHEN v02.mitbewerber_prio = 2 THEN v03.mitbewerber_bez
   END ) prio_2_mitb, MAX(
   CASE  WHEN v02.mitbewerber_prio = 2 THEN v03.mitbewerber_id
   END ) prio_2_mitbewerber_id, MAX(
   CASE  WHEN v02.mitbewerber_prio = 10 THEN v03.mitbewerber_bez
   END ) prio_10_mitb, MAX(
   CASE  WHEN v02.mitbewerber_prio = 10 THEN v03.mitbewerber_id
   END ) prio_10_mitbewerber_id

   FROM dbp_view.v_wup_2  v01
   LEFT JOIN dbp_view.v_vaus_wup_mitbewerber_zu v02
   ON  v01.mandant_id=v02.mandant_id
   AND v01.wup_id=v02.wup_id
   LEFT JOIN dbp_view.v_mitbewerber_spr_zu_2 v03
   ON    v02.mandant_id=v03.mandant_id
   AND v02.mitbewerber_id =   v03.mitbewerber_id
   AND v03.spr_id=22

   WHERE v01.nb_id IN (-2, -1, 0, 2, 7)
   AND v01.dat_eroeffnung > '1900-01-01'
   GROUP BY
   v01.mandant_id
   , v01.nb_id
   , v01.land_id
   , v01.wup_id
   ) t01;