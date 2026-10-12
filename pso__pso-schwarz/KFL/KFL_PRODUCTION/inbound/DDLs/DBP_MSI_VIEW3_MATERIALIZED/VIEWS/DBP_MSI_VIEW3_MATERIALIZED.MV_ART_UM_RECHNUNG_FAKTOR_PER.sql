create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_UM_RECHNUNG_FAKTOR_PER(
	MANDANT_ID,
	ALT_MENGE_EINH_ID,
	ART_ID,
	DAT_VON,
	BRUTTOGEW,
	UMRECH_FAKTOR,
	GEW_EINH_ID,
	DAT_BIS,
	LAENGE,
	BREITE,
	HOEHE
) as
   SELECT
   t1.mandant_id, t1.altnv_menge_einh_id, t1.art_id, t1.dat_von, t1.bruttogew, cast(t1.umrech_zaehler as NUMBER(38,5)) /cast(t1.umrech_nenner as NUMBER(38,5) ) as umrech_faktor, t1.gew_einh_id, t1.dat_bis, t1.laenge, t1.breite, t1.hoehe
   FROM dbp_view.v_art_umrechnung_faktor_per t1
   LEFT JOIN dbp_view.v_art_vorschlagswert_per t2 

   ON t1.art_id = t2.art_id
   AND t1.mandant_id = t2.mandant_id
   AND t1.altnv_menge_einh_id = t2.paletten_faktor_einh_id

   WHERE t1.dat_bis='9999-12-31'
   AND t2.dat_bis='9999-12-31';