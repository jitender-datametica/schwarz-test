CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_VERRECHFALL_KOSTEN_DL_1
-- 13.04.2010  Alex Lipkin   neu erstellt
-- 05.03.2014 srom, Anforderung 583005, Zeit_1 Verrechnung Intern
-- 21.07.2014 srom, vorzeichen_fg für Hilfsattribut zur Berichtsdarstellung
-- 11.03.2016 srom, INC0679096, Ausgrenzung Status_1 analog mv_verrechfall_kosten_1
AS
   SELECT
    v01.mandant_id,
    v01.verrechfall_kosten_id,
    v01.mwst_id,
    v01.storno_fg,
    v01.soll_ist_fg,
    v01.manuelle_erfassung_fg,
    v03.wrg_id,
    v03.wrg_typ_id,
    v01.verrechfall_id,
    v01.dat_verrechnung_intern,
    v01.dat_verrechnung_extern,
    v01.verrechfall_kostenart_id,
    v01.verrechfall_status_id,
    CAST(
        CASE
            WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_kosten * v02.umrechnungskurs)
            ELSE v01.betrag_kosten
        END AS DECIMAL(18, 2)
    ) AS betrag_kosten,
    v01.bemerkung,
    v01.zeit_verrechnung_intern,
    TIMESTAMP_FROM_PARTS(v01.dat_verrechnung_intern,COALESCE(
            v01.zeit_verrechnung_intern,
            '00:00:00')) as dt_verechnung_intern,
    CASE
        WHEN v01.betrag_kosten < 0 THEN 1
        ELSE 0
    END AS vorzeichen_fg,
    belosart_fg
   FROM dbp_view.v_verrechfall_kosten_1 v01
   INNER JOIN dbp_msi_view3.mv_kurs_1 v02
   ON v01.wrg_id=v02.von_wrg_id
   INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03
   ON v01.mandant_id=v03.mandant_id

   -- INC0679096, Ausgrenzung Status_1 analog mv_verrechfall_kosten_1
   WHERE verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090')
   --costqualifier <> Actual  (nur Target und Delta sollen berücksichtigt werden)
   AND soll_ist_fg = 1
   -- Eingeschränkt auf die Daten der Distributionslogistik
   AND belosart_fg =1;