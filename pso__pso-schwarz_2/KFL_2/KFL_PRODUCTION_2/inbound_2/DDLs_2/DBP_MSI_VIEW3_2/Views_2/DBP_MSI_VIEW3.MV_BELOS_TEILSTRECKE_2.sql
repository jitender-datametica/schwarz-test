CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_TEILSTRECKE_2
-- 13.04.2010  AL  Eingeschränkt auf die Daten der Beschaffungslogistik

(
mandant_id
,belos_vorgang_id
,belos_leistungsart_id
,belos_adresse_absender_id
,belos_adresse_empfaenger_id
,sendung_fg
,belos_ladung_id
,teilstrecke_id
,anz_stellplatz
,stellplatz_menge_einh_id
)
AS

   SELECT

   mandant_id, belos_vorgang_id, teilstrecke_nr          AS belos_leistungsart_id, belos_adresse_absender_id, belos_adresse_empfaenger_id, sendung_fg, belos_ladung_id, teilstrecke_id, anz_stellplatz, stellplatz_menge_einh_id

   FROM dbp_view.v_belos_teilstrecke_2

   --  Nur  Billingsystem Daten werden ausgewertet
   WHERE sendung_fg = 1

   AND
   -- Eingeschränkt auf die Daten der Beschaffungslogistik
   belosart_fg = 0
;