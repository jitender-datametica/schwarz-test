create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MA_KOSTENSTELLE_AUSTR_INT_2(
	MANDANT_ID,
	MITARBEITER_ID,
	KJMO,
	KOSTENSTELLE_ID,
	AUSTRITT_INTERN
) as
   SELECT

   v01.mandant_id, v01.mitarbeiter_id, v01.kjmo, v04.kostenstelle_id AS kostenstelle_id_alt, 1 AS austritt_intern

   FROM dbp_view.v_ma_kostenstelle_zu_per_2 v01

   JOIN dbp_msi_view_shr.mv_monat_2 v03
   ON     v01.kjmo              = v03.kjmo

   JOIN dbp_view.v_ma_kostenstelle_zu_per_2 v04
   ON     v01.mitarbeiter_id = v04.mitarbeiter_id
   AND   v03.kjmo_vm        = v04.kjmo
   AND   v01.mandant_id    = v04.mandant_id
   LEFT JOIN dbp_view.v_mitarbeiterbew_2 v99
   ON     v01.mitarbeiter_id = v99.mitarbeiter_id
   AND   v03.kjmo               = v99.kjmo
   AND   v01.mandant_id    = v99.mandant_id

   --WHERE SUBSTR(v01.kostenstelle_id,1,4) <> SUBSTR(v04.kostenstelle_id ,1,4)
   --AND       v04.kostenstelle_id IS NOT NULL
   WHERE v04.kostenstelle_id IS NOT NULL
   --AND haupt_kst_fg_ = 1
   AND v99.ma_austritt_kz in (1,3)
   AND V99.ma_eintritt_kz = 1


   GROUP BY
   1,2,3,4,5
   ;