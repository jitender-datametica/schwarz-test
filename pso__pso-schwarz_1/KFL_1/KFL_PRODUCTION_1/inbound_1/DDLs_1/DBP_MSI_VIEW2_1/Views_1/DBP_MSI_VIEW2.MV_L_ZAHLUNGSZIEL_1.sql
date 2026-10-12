CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_ZAHLUNGSZIEL_1
(
mandant_id
,zahlungsziel
,tagesstufe1
,prozentstufe1
,tagesstufe2
,prozentstufe2
,tagesstufe3
)
AS
   SELECT
   mandant_id, zahlungsziel_id, zahlungsziel_1_tage   AS tagesstufe1, zahlungsziel_1_prozent  AS prozentstufe1, zahlungsziel_2_tage  AS tagesstufe2, zahlungsziel_2_prozent  AS prozentstufe2, zahlungsziel_3_tage  AS tagesstufe3

   FROM dbp_view.v_l_zahlungsziel_1;