CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_BEW_QUAL_1
-- 26.10.2011 system_id entfernt
-- 07.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO_1 beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 26.07.2018 Naku: Anpassung der Cast() da Teradata mit groessere Werte nicht klar kam:
--                 von : INTERVAL HOUR(4) TO SECOND(0)) AS ds_verspaetung
--                 auf: INTERVAL DAY(4) TO SECOND(0)) AS ds_verspaetung
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014
(
mandant_id
,best_beleg_id
,werk_id
,in_lief_id
,dat_lief_wunsch
,flw_beleg_typ_id
,beleg_gruppe_id
,zeit_differenz
,ds_verspaetung
,anz_best_beleg_ok
)
AS
   SELECT
   v01.mandant_id, 
   v01.best_beleg_id, 
   v01.werk_id, 
   v02.flw_lief_id AS in_lief_id, 
   v03.dat_lief_wunsch, 
   v01.flw_beleg_typ_id, 
   v01.beleg_gruppe_id, 
   SNOWCONVERT.PUBLIC.TERADATA_DATEDIFF_INTERVAL_TO_VARCHAR(v01.datzeit_erstellung,v03.datzeit_lief_wunsch) AS zeit_differenz,
   SNOWCONVERT.PUBLIC.TERADATA_DATEDIFF_DIVIDED_INTERVAL_TO_VARCHAR (v01.datzeit_erstellung,v03.datzeit_lief_wunsch, COUNT(v01.best_beleg_id) ) AS ds_verspaetung,
   COUNT(v01.best_beleg_id) AS anz_best_beleg_ok
   
   FROM dbp_view.v_flw_bew_1 v01

   JOIN dbp_view.v_flw_besch_best_1 v02
   ON v01.best_beleg_id = v02.best_beleg_id
   AND v01.mandant_id = v02.mandant_id

   JOIN dbp_view.v_flw_lief_einteilung_1 v03
   ON v01.best_beleg_id = v03.best_beleg_id
   AND v01.best_beleg_pos_id = v03.best_beleg_pos_id
   AND v01.mandant_id = v03.mandant_id

   JOIN dbp_view.v_flw_qual_meldung_1 v04
   ON v01.best_beleg_id = v04.best_beleg_id
   AND v01.mandant_id = v04.mandant_id

   JOIN dbp_view.v_flw_qual_meldung_det_1 v05
   ON v04.qual_meldung_id = v05.qual_meldung_id
   AND v04.mandant_id = v05.mandant_id

   JOIN dbp_view.v_flw_l_fehlgrund_1 v06
   ON v05.fehlgrund_id = v06.fehlgrund_id
   AND v05.mandant_id = v06.mandant_id

   JOIN dbp_view.v_flw_pruefkatalog_code_spr_zu_1 v07
   ON v05.codegruppe_id = v07.codegruppe_id
   AND v05.katalogart_id = v07.katalogart_id
   AND v05.mandant_id = v07.mandant_id
   AND v05.pruefcode_id = v07.pruefcode_id

   WHERE v06.fehlgrund_bez = 'I'
   --QPCT-Filterung auf "Anlieferung  in Ordnung"
   AND v07.katalogart_id = '9'
   AND v07.pruefcode_id = '01'
   AND TRIM(v07.codegruppe_id) LIKE 'Z_1'
   AND v01.datzeit_erstellung <> '1900-01-01 00:00:00'
   AND v02.einkaufsorganisation_id IN (5000,5013,5014)

   GROUP BY 1,2,3,4,5,6,7,V01.DATZEIT_ERSTELLUNG,V03.DATZEIT_LIEF_WUNSCH;
