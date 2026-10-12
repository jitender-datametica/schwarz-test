create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BELEG_LAUFZEIT_2(
	SYSTEM_ID,
	MANDANT_ID,
	BELEG_ID,
	BELEG_GJ,
	DAT_ERFASST,
	DAT_BUCH,
	DAT_BELEG,
	BETRAG_BRUTTO,
	GP_ID,
	BELEGART_ID,
	ERSTELLER_ID,
	WUP_ID,
	NB_ID,
	EINKAUFSORGANISATION_ID,
	ANZ_TAGE,
	MAX_DAT,
	DAT_LZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 05.08.2021 twie: NSR2322930 CAST geändert in try_to_number um '' (blank) abzufangen

   SELECT
   system_id,
   mandant_id,
   beleg_id,
   beleg_gj,
   dat_erfasst,
   dat_buch,
   dat_beleg,
   betrag_brutto_ AS betrag_brutto,
   gp_id,
   belegart_id,
   ersteller_id,
   wup_id,
   nb_id,
   einkaufsorganisation_id,
   anz_tage,
   max_dat,
   dat_lz
   FROM
   (
   SELECT
   7 AS system_id,
   br.mandant_id,
   br.rech_beleg_id  AS beleg_id,
   br.gj AS beleg_gj,
   CASE WHEN br.rech_beleg_status_id = '5' THEN CAST(br.dat_erfasst AS DATE) ELSE NULL END AS dat_erfasst,
   br.dat_buch,
   br.dat_beleg,
   COALESCE(TRY_TO_NUMBER(br.buch_grund_ext_id), 0) AS buch_grund_ext_id_,
   CASE WHEN ((br.belegart_id IN ('HS', 'HK') AND (buch_grund_ext_id_ < 200 OR buch_grund_ext_id_ > 299)) OR
   belegart_id IN ('32', 'HB') OR
   (belegart_id = '31' AND (buch_grund_ext_id_ BETWEEN 200 AND 299)))
   THEN ABS(betrag_brutto)
   ELSE ABS(betrag_brutto) * (-1)
   END AS betrag_brutto_,
   gp_id,
   belegart_id,
   CAST(lz.ersteller_id AS SMALLINT) AS ersteller_id,
   wup_id,
   nb_id,
   einkaufsorganisation_id,
   lz.dat_max - lz.dat_min AS anz_tage,
   lz.dat_max AS max_dat,
   lz.dat_min AS dat_lz
   FROM dbp_view.v_besch_rech_2 br

   JOIN
   (
   SELECT
      s.beleg_id,
      s.beleg_gj,
      MIN(CAST(zeitstempel AS DATE )) AS dat_min,
       COALESCE(MAX(CASE WHEN sgz.statuscode_id IS NULL THEN NULL ELSE CAST(zeitstempel AS DATE ) END), MAX(CAST(zeitstempel AS DATE ))) AS dat_max 
      ,SUBSTRING(COALESCE(MAX(CASE WHEN sgz.statuscode_id IS NULL
                                      THEN NULL
                                      ELSE TO_CHAR(zeitstempel,'YYYY-MM_2-DD HH24:MI:SS.FFFFFF') || TO_VARCHAR(ersteller_id)                           
                               END),
                           MAX(TO_CHAR(zeitstempel,'YYYY-MM_2-DD HH24:MI:SS.FFFFFF') || TO_VARCHAR(ersteller_id) )
                          ),  27, 100) AS ersteller_id  
 
     ,s.mandant_id
   FROM dbp_view.v_statusmeldung_2 s
   LEFT OUTER JOIN
   (
      SELECT *
      FROM dbp_view.v_statuscode_gruppe_zu_2
      WHERE statusgruppe_id = 7
   ) sgz
   ON s.statuscode_id = sgz.statuscode_id AND s.mandant_id = sgz.mandant_id
   WHERE beleg_id > 0
   GROUP BY
        s.beleg_id
       ,s.beleg_gj
        ,s.mandant_id
   ) lz
   ON br.gj = lz.beleg_gj
   AND br.rech_beleg_id = lz.beleg_id
   AND br.mandant_id = lz.mandant_id

   WHERE br.mandant_id = 1
   
   ) lfz;
