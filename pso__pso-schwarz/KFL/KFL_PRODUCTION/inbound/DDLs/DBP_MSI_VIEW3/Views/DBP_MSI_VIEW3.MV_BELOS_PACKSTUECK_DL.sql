CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_PACKSTUECK_DL
--  11.01.2011  AL Erstellt
-- 09.08.2011 srom, Anforderung 501447, Feld nettogew_avisiert

(
mandant_id
,belos_vorgang_id
,packstueck_gebinde_einh_id
,packstueck_gebindeart_id
,bruttogew_avisiert
,sendung_fg
,nettogew_avisiert
)
AS
   SELECT

   mandant_id, belos_vorgang_id, packstueck_gebinde_einh_id, packstueck_gebindeart_id, bruttogew_avisiert, sendung_fg, nettogew_avisiert

   FROM dbp_view.v_belos_packstueck
   WHERE

   -- Eingeschränkt auf die Daten der Distributionslogistik
   belosart_fg = 1;