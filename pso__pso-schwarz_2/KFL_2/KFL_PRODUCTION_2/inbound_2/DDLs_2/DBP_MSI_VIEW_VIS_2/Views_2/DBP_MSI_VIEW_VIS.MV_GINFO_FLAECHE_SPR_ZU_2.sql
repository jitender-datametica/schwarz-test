CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GINFO_FLAECHE_SPR_ZU_2
AS
   -- SPRACHE : G-Info Flaechen
   -- Join ueber Fakt-Tabelle (Gueltigkeit) ohne Schluessel Techn. Platz.
   -- Sprachfilter in Subselect
   -- 2012KW46 : Initial
   -- 2017.0727 ssch0611 : Anpassung Filterung, Gruppierung

   SELECT DISTINCT
   gfp.mandant_id, 0::BYTEINT AS flaeche_quelle_id -- NOT USED
   , gfp.ginfo_flaeche_typ_id, gfp.ginfo_flaeche_id, gfsz.ginfo_flaeche_bez
   FROM dbp_view.v_ginfo_flaeche_per_2 gfp

   JOIN
   (
  SELECT DISTINCT
mandant_id
, ginfo_flaeche_typ_id
, ginfo_flaeche_id
, MAX(ginfo_flaeche_bez) ginfo_flaeche_bez

FROM dbp_view.v_ginfo_flaeche_spr_zu_2
  GROUP BY 1,2,3
) gfsz
ON gfsz.mandant_id = gfp.mandant_id
AND gfsz.ginfo_flaeche_id = gfp.ginfo_flaeche_id
AND gfsz.ginfo_flaeche_typ_id = gfp.ginfo_flaeche_typ_id

WHERE gfp.dat_bis = '9999-12-31';