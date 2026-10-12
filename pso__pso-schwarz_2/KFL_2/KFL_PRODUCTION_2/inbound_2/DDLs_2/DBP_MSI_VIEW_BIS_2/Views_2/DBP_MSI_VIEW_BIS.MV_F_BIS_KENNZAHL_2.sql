CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_BIS_KENNZAHL_2
--04.07.2016 twie: SPEC0008548 neue Kennzahlen aus Transaction Bericht. Wird in Euro eingegeben, keine Währungsumrechnung vorgesehen
--17.08.2016 twie: Für Land_2 INT (Mandant_2 99) in eigene Tabelle ohne Mandant_2 speichern, Mandant_2 nur für MSI dazuerfinden, solange es im Datenmodell keine bessere Lösung gibt.

(
gjqu
,mandant_id
,einsparung
,volumen
,e_sourcing
,anz_vertraege
,anz_verhandlungen
)
AS
   SELECT
   v01.gjqu,
   v01.mandant_id,
   SUM(CASE WHEN v01.bis_kennzahl_id = 1 THEN v01.bis_kennzahl_betrag ELSE NULL END) AS einsparung,
   SUM(CASE WHEN v01.bis_kennzahl_id = 2 THEN v01.bis_kennzahl_betrag ELSE NULL END) AS volumen,
   SUM(CASE WHEN v01.bis_kennzahl_id = 3 THEN v01.bis_kennzahl_betrag ELSE NULL END) AS e_sourcing,
   SUM(CASE WHEN v01.bis_kennzahl_id = 4 THEN v01.bis_kennzahl_betrag ELSE NULL END) AS anz_vertraege,
   SUM(CASE WHEN v01.bis_kennzahl_id = 5 THEN v01.bis_kennzahl_betrag ELSE NULL END) AS anz_verhandlungen
   --FROM dbp_msi_view_bis.ts_bis_kennzahl_2 v01
   FROM
   dbp_msi_view_bis.ts_bis_kennzahl_2 v01
   GROUP BY 1,2

   UNION

   SELECT
   v02.gjqu,
   99 AS mandant_id,
   SUM(CASE WHEN v02.bis_kennzahl_id = 1 THEN v02.bis_kennzahl_betrag ELSE NULL END) AS einsparung,
   SUM(CASE WHEN v02.bis_kennzahl_id = 2 THEN v02.bis_kennzahl_betrag ELSE NULL END) AS volumen,
   SUM(CASE WHEN v02.bis_kennzahl_id = 3 THEN v02.bis_kennzahl_betrag ELSE NULL END) AS e_sourcing,
   SUM(CASE WHEN v02.bis_kennzahl_id = 4 THEN v02.bis_kennzahl_betrag ELSE NULL END) AS anz_vertraege,
   SUM(CASE WHEN v02.bis_kennzahl_id = 5 THEN v02.bis_kennzahl_betrag ELSE NULL END) AS anz_verhandlungen
   --FROM dbp_msi_view_bis.ts_bis_kennzahl_int_2 v02
   FROM
   dbp_msi_view_bis.ts_bis_kennzahl_int_2 v02
   GROUP BY 1,2
;