CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEG_LAUFZEIT
-- 05.08.2021 twie: NSR2322930 CAST geändert in try_to_number um '' (blank) abzufangen

(
system_id
,mandant_id
,beleg_id
,beleg_gj
,dat_erfasst
,dat_buch
,dat_beleg
,betrag_brutto
,gp_id
,belegart_id
,ersteller_id
,wup_id
,nb_id
,einkaufsorganisation_id
,anz_tage
,max_dat
,dat_lz
)
AS
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
   COALESCE(try_to_number(br.buch_grund_ext_id), 0) AS buch_grund_ext_id_,
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
   FROM dbp_view.v_besch_rech br

   JOIN
   (
   SELECT
      s.beleg_id,
      s.beleg_gj,
      MIN(CAST(zeitstempel AS DATE )) AS dat_min,
       COALESCE(MAX(CASE WHEN sgz.statuscode_id IS NULL THEN NULL ELSE CAST(zeitstempel AS DATE ) END), MAX(CAST(zeitstempel AS DATE ))) AS dat_max 
      ,SUBSTRING(COALESCE(MAX(CASE WHEN sgz.statuscode_id IS NULL
                                      THEN NULL
                                      ELSE to_char(zeitstempel,'YYYY-MM-DD HH24:MI:SS.FFFFFF') || to_varchar(ersteller_id)                           
                               END),
                           MAX(to_char(zeitstempel,'YYYY-MM-DD HH24:MI:SS.FFFFFF') || to_varchar(ersteller_id) )
                          ),  27, 100) AS ersteller_id  
 
     ,s.mandant_id
   FROM dbp_view.v_statusmeldung s
   LEFT OUTER JOIN
   (
      SELECT *
      FROM dbp_view.v_statuscode_gruppe_zu
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