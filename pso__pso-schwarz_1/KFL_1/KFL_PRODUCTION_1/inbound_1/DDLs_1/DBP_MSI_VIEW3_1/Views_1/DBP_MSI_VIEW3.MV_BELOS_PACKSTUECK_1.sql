CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_PACKSTUECK_1
--  11.01.2010  AL Anpassung gebinde_anz. Es ist nur aus Billingssystem
--  13.04.2010  AL Eingeschränkt auf die Daten der Beschaffungslogistik
--  09.08.2011 srom, Anforderung 501447, Feld nettogew_avisiert
(
mandant_id
,belos_vorgang_id
,packstueck_gebinde_einh_id
,packstueck_gebindeart_id
,gebinde_anz
,bruttogew_avisiert
,sendung_fg
,nettogew_avisiert
)
AS
   SELECT

   mandant_id, belos_vorgang_id, packstueck_gebinde_einh_id, packstueck_gebindeart_id, CASE WHEN sendung_fg = 1 THEN  gebinde_anz   ELSE NULL END AS  gebinde_anz, bruttogew_avisiert, sendung_fg, nettogew_avisiert

   FROM dbp_view.v_belos_packstueck_1
   WHERE

   -- Eingeschränkt auf die Daten der Beschaffungslogistik
   belosart_fg = 0;