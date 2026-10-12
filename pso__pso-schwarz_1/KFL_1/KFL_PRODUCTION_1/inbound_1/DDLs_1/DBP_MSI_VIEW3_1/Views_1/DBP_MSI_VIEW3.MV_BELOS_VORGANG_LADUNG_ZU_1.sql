CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_VORGANG_LADUNG_ZU_1

(
mandant_id
,belos_vorgang_id
,teilstrecke_nr
,belos_adresse_absender_id
,belos_adresse_empfaenger_id
,sendung_fg
,belos_ladung_id
,teilstrecke_id
)
AS
   SELECT

   mandant_id, belos_vorgang_id, teilstrecke_nr, belos_adresse_absender_id, belos_adresse_empfaenger_id, sendung_fg, belos_ladung_id, teilstrecke_id
   FROM dbp_view.v_belos_teilstrecke_1

   --  Daten aus Transportmanagementsystem
   WHERE sendung_fg=0;