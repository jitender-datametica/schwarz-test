CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_GP_WUP_ZU_PER
(
mandant_id,
art_id,
gp_id,
wup_id,
nb_id,
dat_von,
dat_bis,
ek_netto_bnk,
logistikkostenzuschlag,
bezugsweg_id,
komponentenmenge,
wrg_id
)
AS
   SELECT
   mandant_id,
   art_id,
   gp_id,
   wup_id,
   nb_id,
   dat_von,
   dat_bis,
   ek_netto_bnk,
   logistikkostenzuschlag,
   bezugsweg_id,
   komponentenmenge,
   wrg_id
   FROM dbp_view.v_art_gp_wup_zu_per
   WHERE
   EK_Netto <> 0

   QUALIFY SUM(1) OVER (PARTITION BY mandant_id,art_id,wup_id ORDER BY dat_von DESC NULLS LAST, ek_brutto DESC NULLS LAST, gp_id ROWS UNBOUNDED PRECEDING) = 1;