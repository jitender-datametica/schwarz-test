CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ARTBEW_MO_EK_CP_SUM
(
   mandant_id,
   art_id,
   bewart_id,
   wup_id,
   nb_id,
   kjmo,
   wrg_id,
   wup_bereinigt_fg,
   zek_id,
   eigenmarke_fg,
   umsatz_netto,
   umsatz_netto_vj,
   betrag_kmep,
   betrag_kmep_vj,
   betrag_kmep_o_fwu,
   betrag_kmep_o_fwu_vj,
   logkostenzuschlag,
   logkostenzuschlag_vj,
   werbe_abschrift_netto,
   werbe_abschrift_netto_vj,
   preis_abschrift_netto,
   preis_abschrift_netto_vj
)
AS
   SELECT
   mandant_id,
   art_id,
   bewart_id,
   wup_id,
   nb_id,
   kjmo,
   wrg_id,
   wup_bereinigt_fg,
   zek_id,
   eigenmarke_fg,
   --menge, nicht in MO enthalten
   umsatz_netto,
   umsatz_netto_vj,
   betrag_kmep,
   betrag_kmep_vj,
   betrag_kmep_o_fwu,
   betrag_kmep_o_fwu_vj,
   logkostenzuschlag,
   logkostenzuschlag_vj,
   werbe_abschrift_netto,
   werbe_abschrift_netto_vj,
   preis_abschrift_netto,
   preis_abschrift_netto_vj
   
   FROM dbp_data.artbew_mo_ek_cp_sum
   WHERE NOT (art_id IN (98001300, 98001310, 98001320) AND mandant_id = 6);
        