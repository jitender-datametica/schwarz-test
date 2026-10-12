CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_SORTIMENT_WG_VERTEILUNG_2
-- Erweiterung um KL-WG Hierarchie Felder fÃ¼r KMO / sschuecke11.06.2018
(
mandant_id
,kjmo
,kl_uwg_id
,kl_wg_id
,kl_owg_id
,nielsen_umsatz_anteil_owg
,nielsen_umsatz_anteil_uwg
,nielsen_artikel_anteil_owg
,nielsen_artikel_anteil_uwg
,kl_umsatz_anteil_owg
,kl_umsatz_anteil_uwg
,kl_artikel_anteil_owg
,kl_artikel_anteil_uwg
,kl_ertrag_anteil_owg
,kl_ertrag_anteil_uwg
)
AS
   SELECT

   mandant_id, kjmo, wug_id AS kl_uwg_id, owg_id AS kl_wg_id, wg_id AS kl_owg_id, nielsen_umsatz_anteil_owg, nielsen_umsatz_anteil_uwg, nielsen_artikel_anteil_owg, nielsen_artikel_anteil_uwg, kl_umsatz_anteil_owg, kl_umsatz_anteil_uwg, kl_artikel_anteil_owg, kl_artikel_anteil_uwg, kl_ertrag_anteil_owg, kl_ertrag_anteil_uwg


   FROM dbp_view.v_sortiment_wg_verteilung_2;