CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_RABATTARTEN_SPR_ZU_1 AS
SELECT 0 AS rabattart_id , 
    'Prozent' AS beschreibung,
    'Prozent' AS beschreibung_de,
    'Percentage' AS beschreibung_cz,
    'Percentage' AS beschreibung_pl,
    'Percentage' AS beschreibung_sk,
    'postotak' AS beschreibung_hr,
    'Percentage' AS beschreibung_ro,
    'Percentage' AS beschreibung_bg,
    'Percentage' AS beschreibung_en 
UNION 
SELECT  1 AS id , 
    'Währung' AS beschreibung,
    'Währung' AS beschreibung_de,
    'Currency' AS beschreibung_cz,
    'Currency' AS beschreibung_pl,
    'Currency' AS beschreibung_sk,
    'valuta' AS beschreibung_hr,
    'Currency' AS beschreibung_ro,
    'Currency' AS beschreibung_bg,
    'Currency' AS beschreibung_en
;