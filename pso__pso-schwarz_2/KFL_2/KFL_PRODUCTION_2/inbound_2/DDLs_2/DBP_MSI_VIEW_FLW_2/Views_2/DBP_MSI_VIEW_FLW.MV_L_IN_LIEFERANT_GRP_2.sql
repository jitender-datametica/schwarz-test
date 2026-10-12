CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LIEFERANT_GRP_2
-- AL 28.06.2011mandant_id aus der View Rausgenommen
-- 13.12.2012 twie: statt werk_id die werk_id_flw auslesen, da werk_id durch Projekt SAKO anders verwendet
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014

(
lieferantlv2_id
,  lieferantlv2_bez
,  lieferantentyp
)
AS
   SELECT

   CASE WHEN v01.werk_id_flw <> -1 THEN v01.werk_id_flw
   ELSE v01.werk_id_flw
   END AS lieferantlv2_id, MAX(CASE WHEN v01.werk_id_flw <> -1 THEN v02.werk_name
   ELSE 'Extern'  --v01.lief_name
   END) AS lieferantlv2_bez, MAX(CASE WHEN v01.werk_id_flw <> -1 THEN 'Intern'
   ELSE 'Extern'
   END) AS lieferantentyp

   FROM dbp_view.v_flw_lieferant_2 v01
   LEFT JOIN dbp_view.v_flw_werk_2 v02
   ON v01.werk_id_flw  =  v02.werk_id
   AND v01.mandant_id_werk =  v02.mandant_id
   INNER JOIN dbp_view.v_flw_lieferant_ekorg_zu_2 dt2
   ON v01.mandant_id = dt2.mandant_id
   AND v01.flw_lief_id = dt2.flw_lief_id

   WHERE dt2.einkaufsorganisation_id IN (5000,5013,5014)
   GROUP BY lieferantlv2_id;