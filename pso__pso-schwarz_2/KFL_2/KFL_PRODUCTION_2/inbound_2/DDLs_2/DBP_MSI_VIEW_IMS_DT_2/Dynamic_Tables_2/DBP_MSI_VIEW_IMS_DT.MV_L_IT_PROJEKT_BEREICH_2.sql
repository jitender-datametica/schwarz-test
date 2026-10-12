CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IT_PROJEKT_BEREICH_2
(
	IT_PROJEKT_BEREICH_ID,
	MANDANT_ID,
	IT_PROJEKT_BEREICH_BEZ,
	SPARTE_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 03.04.2013 AL Init
-- 13.05.2016 twie SPEC0009845: neue Quelle für Fachbereich, nicht mehr der it_projekt_bereich, sondern die hr_objekt_ebene11
-- Damit Altdaten (nicht migriert) weiterhin ausgewertet werden könne, beide Quellen in eine_2 Lookupview zusammenführen.
-- erweitert um mandant_id, da diese bei hr_ojekt_ebene11 zum Schlüssel gehört
-- 12.03.2018 twie: SPEC0051965: wegen Bezeichnungsfeld von Tabelle l_org_einheit_sparte_2 auf org_einheit_hierarchie_2 gewechselt
-- diese ist historisiert, deshalb immer den aktuellsten Monat_2 ermitteln und aus diesem Datensatz die dt. Bezeichnung holen

   --neue Struktur aus org_einheit
   SELECT
   --da it_projekt_bereich_id CHAR ist (s.u.), den Decimalwert auch in CHAR umwandeln
   CAST(CAST(v01.hr_objekt_ebene1_id AS INTEGER) AS CHAR(10)) AS it_projekt_bereich_id,
   v01.mandant_id,
   --Tabelle ist denormalisisert, wenn es zu einer ID mehrere Bez gibt, die "höchste" nehmen
   MAX(v01.hr_objekt_ebene1_bez) AS it_projekt_bereich_bez,
   MAX(v03.sparte_id) AS sparte_id

   FROM dbp_view.v_org_einheit_hierarchie_2 v01  --wegen Bez.feld diese Tabelle statt l_org_einheit_sparte_2

  --Tabelle ist historisiert, deshalb aktuellsten Datensatz mit höchstem Monat_2 ermitteln
   INNER JOIN (
   SELECT
   hr_objekt_ebene1_id,
   mandant_id,
   spr_id,
   MAX(kjmo) AS max_kjmo
   FROM dbp_view.v_org_einheit_hierarchie_2
   WHERE spr_id = 22 --fest auf deutsche Bezeichnung
   GROUP BY
   hr_objekt_ebene1_id
   ,mandant_id
   ,spr_id
   ) v02
   ON
   v01.hr_objekt_ebene1_id = v02.hr_objekt_ebene1_id AND
   v01.mandant_id = v02.mandant_id AND
   v01.kjmo = v02.max_kjmo AND
   v01.spr_id = v02.spr_id

   --Ermittllung der Sparte
   INNER JOIN dbp_view.v_l_org_einheit_sparte_2 v03
   ON
   v01.hr_objekt_ebene1_id = v03.hr_objekt_ebene11_id AND
   v01.mandant_id = v03.mandant_id

   GROUP BY  it_projekt_bereich_id, v01.mandant_id


   UNION ALL


   --alte Struktur aus l_it_projekt_bereich_2 (für Altdaten behalten)
   SELECT
   it_projekt_bereich_id, --CHAR
   mandant_id,
   it_projekt_bereich_bez,
   sparte_id

   FROM dbp_view.v_l_it_projekt_bereich_2
;