CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_MASSNAHME_2 as
   -- Faktview : Massnahmengruppe gemäß: AP0005260
   -- 20161129 tuts1605 : initial
   --20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung: massnahmenart_bez und massnahmenart_gruppe ausgelagert in spr_zu
   --20180316 nfis0811: View erstmal zurückgebaut, da im FE die massnahmengruppe als ID die bez hat; Umbau nicht so einfach
   -- 201211 cbru1709: Änderungen laut Vorgabe von msar2108 übernommen.
   -- 20200302 cbru1709: neues Feld massnahme_akt_fg

   SELECT
    v01.massnahme_id, v01.massnahmenart_id, v02.massnahmenart_bez, v01.massnahme_akt_fg, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 10
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 30
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 40
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 50
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 70
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 90
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 110
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 130
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 150
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 170
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 190
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 210
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 230
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 260
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 290
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 320
   WHEN v01.massnahmenart_id = 999 THEN 999
  END AS massnahmen_gruppe_id, CASE
   WHEN v01.massnahmenart_id BETWEEN 10  AND 29  THEN 'Expansion | Neubau'
   WHEN v01.massnahmenart_id BETWEEN 30  AND 39  THEN 'Übernahme'
   WHEN v01.massnahmenart_id BETWEEN 40  AND 49  THEN 'Filialmaßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 50  AND 69  THEN 'Modernisierung'
   WHEN v01.massnahmenart_id BETWEEN 70  AND 89  THEN 'Standortoptimierungsauftrag'
   WHEN v01.massnahmenart_id BETWEEN 90  AND 109 THEN 'Reorga'
   WHEN v01.massnahmenart_id BETWEEN 110 AND 129 THEN 'Schließung'
   WHEN v01.massnahmenart_id BETWEEN 130 AND 149 THEN 'Marktgestaltung | Rückfilialisierung'
   WHEN v01.massnahmenart_id BETWEEN 150 AND 169 THEN 'Sonstige Maßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 170 AND 189 THEN 'Konzessionärsmaßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 190 AND 209 THEN 'Gastromaßnahmen'
   WHEN v01.massnahmenart_id BETWEEN 210 AND 229 THEN 'Instandsetzungen | Sanierungen'
   WHEN v01.massnahmenart_id BETWEEN 230 AND 259 THEN 'Expansion | Neubau Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 260 AND 289 THEN 'Standortoptimierungsauftrag Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 290 AND 319 THEN 'Baumaßnahme Sonderbauten'
   WHEN v01.massnahmenart_id BETWEEN 320 AND 339 THEN 'sonstige Maßnahme Sonderbauten'
   WHEN v01.massnahmenart_id = 999 THEN 'nicht zugeordnet'
   END AS massnahmen_gruppe

   FROM dbp_view.v_l_massnahme_2 v01
   --LEFT 
   JOIN
   dbp_view.v_massnahmenart_spr_zu_2 v02
   ON v01.massnahmenart_id = v02.massnahmenart_id
   --LEFT 
   JOIN
   dbp_view.v_l_massnahmenart_2 v03
   ON v01.massnahmenart_id = v03.massnahmenart_id
   AND v02.spr_id = 22;