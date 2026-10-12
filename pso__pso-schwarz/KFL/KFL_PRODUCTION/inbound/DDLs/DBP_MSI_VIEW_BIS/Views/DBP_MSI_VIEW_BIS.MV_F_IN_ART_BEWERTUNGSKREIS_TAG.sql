CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_ART_BEWERTUNGSKREIS_TAG
-- 04.08.2017 ttez:  Initial
--31.08.2017 ttez: Bedingung in WHERE-Bedingung für die relevanten Artikel hinzugefügt.
--27.11.2017 twie: Aus Performancegründen die 0 Bestände in eigenen Select aufgeteilt, da dort keine Wrg umrechnung nötig.

(
mandant_id
,in_art_id
,bewertungskreis_id
,dat
,menge_bestand_bme
,betrag_preis_bestand
)
AS

   SELECT
   v1.mandant_id,
   v1.in_art_id,
   v1.bewertungskreis_id,
   v1.dat,
   v1.menge_bestand_bme,
   CASE WHEN v3.wrg_typ_id = 0
   THEN CAST(v1.betrag_preis_bestand AS NUMBER(38,5))  * v4.umrechnungskurs
   ELSE CAST(v1.betrag_preis_bestand AS NUMBER(38,5))
   END as betrag_preis_bestand
   FROM dbp_view.v_in_art_bewertungskreis_tag v1
   INNER JOIN dbp_view.v_mandant v2
   ON v1.mandant_id=v2.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v3

   JOIN dbp_view.v_kurs v4
   ON   v4.von_wrg_id = v2.default_wrg AND (v1.dat BETWEEN v4.dat_von and v4.dat_bis) AND v4.kurstyp_id = 9  AND v4.nach_wrg_id = 'EUR'

   JOIN dbp_view.v_in_art e
   ON e.mandant_id = v1.mandant_id and e.in_art_id = v1.in_art_id

   WHERE ( (e.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
   OR SUBSTR( e.in_art_nr, 1, 1) = 'W'
   OR e.in_art_id = -1)

   AND betrag_preis_bestand  <> 0
   )


   UNION ALL

   SELECT
   v1.mandant_id,
   v1.in_art_id,
   v1.bewertungskreis_id,
   v1.dat,
   v1.menge_bestand_bme,
   v1.betrag_preis_bestand

   FROM dbp_view.v_in_art_bewertungskreis_tag v1

   JOIN dbp_view.v_in_art e
   ON e.mandant_id = v1.mandant_id and e.in_art_id = v1.in_art_id

   WHERE ( (e.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
   OR SUBSTR( e.in_art_nr, 1, 1) = 'W'
   OR e.in_art_id = -1)

   AND betrag_preis_bestand = 0
   )

;