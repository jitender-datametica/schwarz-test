CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_tickets_country_1 (country_ticket_id, country_name, country_flag_img,
country_flag_img_name, opened_by_group) AS SELECT DISTINCT country_ticket_id,
  CASE
  WHEN STRPOS(country_ticket_id, 'MT') <> 0
  THEN 'Malta'
  WHEN STRPOS(country_ticket_id, 'ES') <> 0
  THEN 'Spanien'
  WHEN STRPOS(country_ticket_id, 'IT') <> 0
  THEN 'Italien'
  WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') <> 0
  THEN 'Stiftung inkl. Schwarz IT'
  WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') = 0
  THEN 'Deutschland'
  WHEN STRPOS(country_ticket_id, 'CY') <> 0
  THEN 'Zypern'
  WHEN STRPOS(country_ticket_id, 'NI') <> 0
  THEN 'Nordirland'
  WHEN STRPOS(country_ticket_id, 'GR') <> 0
  THEN 'Griechenland'
  WHEN STRPOS(country_ticket_id, 'DK') <> 0
  THEN 'Daenemark'
  WHEN STRPOS(country_ticket_id, 'BE') <> 0
  THEN 'Belgien'
  WHEN STRPOS(country_ticket_id, 'PT') <> 0
  THEN 'Portugal'
  WHEN STRPOS(country_ticket_id, 'FI') <> 0
  THEN 'Finnland'
  WHEN STRPOS(country_ticket_id, 'GB') <> 0
  THEN 'Grossbritannien'
  WHEN STRPOS(country_ticket_id, 'CZ') <> 0
  THEN 'Tschechien'
  WHEN STRPOS(country_ticket_id, 'HR') <> 0
  THEN 'Kroatien'
  WHEN STRPOS(country_ticket_id, 'CH') <> 0
  THEN 'Schweiz'
  WHEN STRPOS(country_ticket_id, 'SI') <> 0
  THEN 'Slowenien'
  WHEN STRPOS(country_ticket_id, 'FR') <> 0
  THEN 'Frankreich'
  WHEN STRPOS(country_ticket_id, 'HU') <> 0
  THEN 'Ungarn'
  WHEN STRPOS(country_ticket_id, 'AT') <> 0
  THEN 'Oesterreich'
  WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') <> 0
  THEN 'Stiftung inkl. Schwarz IT'
  WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') = 0
  THEN 'Polen'
  WHEN STRPOS(country_ticket_id, 'BG') <> 0
  THEN 'Bulgarien'
  WHEN STRPOS(country_ticket_id, 'CS') <> 0
  THEN 'Kanarische-Inseln'
  WHEN STRPOS(country_ticket_id, 'US') <> 0
  THEN 'USA'
  WHEN STRPOS(country_ticket_id, 'SE') <> 0
  THEN 'Schweden'
  WHEN STRPOS(country_ticket_id, 'SK') <> 0
  THEN 'Slowakei'
  WHEN STRPOS(country_ticket_id, 'RS_1') <> 0
  THEN 'Serbien'
  WHEN STRPOS(country_ticket_id, 'RO') <> 0
  THEN 'Rumaenien'
  WHEN STRPOS(country_ticket_id, 'IE') <> 0
  THEN 'Irland'
  WHEN STRPOS(country_ticket_id, 'NL') <> 0
  THEN 'Niederlande'
  WHEN STRPOS(country_ticket_id, 'LT') <> 0
  THEN 'Litauen'
  WHEN STRPOS(country_ticket_id, 'LV') <> 0
  THEN 'Lettland'
  WHEN country_ticket_id LIKE 'S' OR country_ticket_id LIKE 'S-HQ'
  THEN 'Stiftung inkl. Schwarz IT'
  WHEN STRPOS(country_ticket_id, 'EE') <> 0
  THEN 'Estland'
  ELSE NULL
  END AS country_name,
  CASE
  WHEN CASE
    WHEN STRPOS(country_ticket_id, 'MT') <> 0
    THEN 'Malta'
    WHEN STRPOS(country_ticket_id, 'ES') <> 0
    THEN 'Spanien'
    WHEN STRPOS(country_ticket_id, 'IT') <> 0
    THEN 'Italien'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') = 0
    THEN 'Deutschland'
    WHEN STRPOS(country_ticket_id, 'CY') <> 0
    THEN 'Zypern'
    WHEN STRPOS(country_ticket_id, 'NI') <> 0
    THEN 'Nordirland'
    WHEN STRPOS(country_ticket_id, 'GR') <> 0
    THEN 'Griechenland'
    WHEN STRPOS(country_ticket_id, 'DK') <> 0
    THEN 'Daenemark'
    WHEN STRPOS(country_ticket_id, 'BE') <> 0
    THEN 'Belgien'
    WHEN STRPOS(country_ticket_id, 'PT') <> 0
    THEN 'Portugal'
    WHEN STRPOS(country_ticket_id, 'FI') <> 0
    THEN 'Finnland'
    WHEN STRPOS(country_ticket_id, 'GB') <> 0
    THEN 'Grossbritannien'
    WHEN STRPOS(country_ticket_id, 'CZ') <> 0
    THEN 'Tschechien'
    WHEN STRPOS(country_ticket_id, 'HR') <> 0
    THEN 'Kroatien'
    WHEN STRPOS(country_ticket_id, 'CH') <> 0
    THEN 'Schweiz'
    WHEN STRPOS(country_ticket_id, 'SI') <> 0
    THEN 'Slowenien'
    WHEN STRPOS(country_ticket_id, 'FR') <> 0
    THEN 'Frankreich'
    WHEN STRPOS(country_ticket_id, 'HU') <> 0
    THEN 'Ungarn'
    WHEN STRPOS(country_ticket_id, 'AT') <> 0
    THEN 'Oesterreich'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') = 0
    THEN 'Polen'
    WHEN STRPOS(country_ticket_id, 'BG') <> 0
    THEN 'Bulgarien'
    WHEN STRPOS(country_ticket_id, 'CS') <> 0
    THEN 'Kanarische-Inseln'
    WHEN STRPOS(country_ticket_id, 'US') <> 0
    THEN 'USA'
    WHEN STRPOS(country_ticket_id, 'SE') <> 0
    THEN 'Schweden'
    WHEN STRPOS(country_ticket_id, 'SK') <> 0
    THEN 'Slowakei'
    WHEN STRPOS(country_ticket_id, 'RS_1') <> 0
    THEN 'Serbien'
    WHEN STRPOS(country_ticket_id, 'RO') <> 0
    THEN 'Rumaenien'
    WHEN STRPOS(country_ticket_id, 'IE') <> 0
    THEN 'Irland'
    WHEN STRPOS(country_ticket_id, 'NL') <> 0
    THEN 'Niederlande'
    WHEN STRPOS(country_ticket_id, 'LT') <> 0
    THEN 'Litauen'
    WHEN STRPOS(country_ticket_id, 'LV') <> 0
    THEN 'Lettland'
    WHEN country_ticket_id LIKE 'S' OR country_ticket_id LIKE 'S-HQ'
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'EE') <> 0
    THEN 'Estland'
    ELSE NULL
    END = 'Stiftung inkl. Schwarz IT'
  THEN '<img src="../images/lidl/BCBI/Länderflaggen/schwarz_logo.jpg"\\n        style="width:25px"/>'
  ELSE CONCAT('<img src="../images/lidl/BCBI/Länderflaggen/Flaggen_RGB_', CASE
    WHEN STRPOS(country_ticket_id, 'MT') <> 0
    THEN 'Malta'
    WHEN STRPOS(country_ticket_id, 'ES') <> 0
    THEN 'Spanien'
    WHEN STRPOS(country_ticket_id, 'IT') <> 0
    THEN 'Italien'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') = 0
    THEN 'Deutschland'
    WHEN STRPOS(country_ticket_id, 'CY') <> 0
    THEN 'Zypern'
    WHEN STRPOS(country_ticket_id, 'NI') <> 0
    THEN 'Nordirland'
    WHEN STRPOS(country_ticket_id, 'GR') <> 0
    THEN 'Griechenland'
    WHEN STRPOS(country_ticket_id, 'DK') <> 0
    THEN 'Daenemark'
    WHEN STRPOS(country_ticket_id, 'BE') <> 0
    THEN 'Belgien'
    WHEN STRPOS(country_ticket_id, 'PT') <> 0
    THEN 'Portugal'
    WHEN STRPOS(country_ticket_id, 'FI') <> 0
    THEN 'Finnland'
    WHEN STRPOS(country_ticket_id, 'GB') <> 0
    THEN 'Grossbritannien'
    WHEN STRPOS(country_ticket_id, 'CZ') <> 0
    THEN 'Tschechien'
    WHEN STRPOS(country_ticket_id, 'HR') <> 0
    THEN 'Kroatien'
    WHEN STRPOS(country_ticket_id, 'CH') <> 0
    THEN 'Schweiz'
    WHEN STRPOS(country_ticket_id, 'SI') <> 0
    THEN 'Slowenien'
    WHEN STRPOS(country_ticket_id, 'FR') <> 0
    THEN 'Frankreich'
    WHEN STRPOS(country_ticket_id, 'HU') <> 0
    THEN 'Ungarn'
    WHEN STRPOS(country_ticket_id, 'AT') <> 0
    THEN 'Oesterreich'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') = 0
    THEN 'Polen'
    WHEN STRPOS(country_ticket_id, 'BG') <> 0
    THEN 'Bulgarien'
    WHEN STRPOS(country_ticket_id, 'CS') <> 0
    THEN 'Kanarische-Inseln'
    WHEN STRPOS(country_ticket_id, 'US') <> 0
    THEN 'USA'
    WHEN STRPOS(country_ticket_id, 'SE') <> 0
    THEN 'Schweden'
    WHEN STRPOS(country_ticket_id, 'SK') <> 0
    THEN 'Slowakei'
    WHEN STRPOS(country_ticket_id, 'RS_1') <> 0
    THEN 'Serbien'
    WHEN STRPOS(country_ticket_id, 'RO') <> 0
    THEN 'Rumaenien'
    WHEN STRPOS(country_ticket_id, 'IE') <> 0
    THEN 'Irland'
    WHEN STRPOS(country_ticket_id, 'NL') <> 0
    THEN 'Niederlande'
    WHEN STRPOS(country_ticket_id, 'LT') <> 0
    THEN 'Litauen'
    WHEN STRPOS(country_ticket_id, 'LV') <> 0
    THEN 'Lettland'
    WHEN country_ticket_id LIKE 'S' OR country_ticket_id LIKE 'S-HQ'
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'EE') <> 0
    THEN 'Estland'
    ELSE NULL
    END, '.png" style="width:25px"/>')
  END AS country_flag_img,
  CASE
  WHEN CASE
    WHEN STRPOS(country_ticket_id, 'MT') <> 0
    THEN 'Malta'
    WHEN STRPOS(country_ticket_id, 'ES') <> 0
    THEN 'Spanien'
    WHEN STRPOS(country_ticket_id, 'IT') <> 0
    THEN 'Italien'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') = 0
    THEN 'Deutschland'
    WHEN STRPOS(country_ticket_id, 'CY') <> 0
    THEN 'Zypern'
    WHEN STRPOS(country_ticket_id, 'NI') <> 0
    THEN 'Nordirland'
    WHEN STRPOS(country_ticket_id, 'GR') <> 0
    THEN 'Griechenland'
    WHEN STRPOS(country_ticket_id, 'DK') <> 0
    THEN 'Daenemark'
    WHEN STRPOS(country_ticket_id, 'BE') <> 0
    THEN 'Belgien'
    WHEN STRPOS(country_ticket_id, 'PT') <> 0
    THEN 'Portugal'
    WHEN STRPOS(country_ticket_id, 'FI') <> 0
    THEN 'Finnland'
    WHEN STRPOS(country_ticket_id, 'GB') <> 0
    THEN 'Grossbritannien'
    WHEN STRPOS(country_ticket_id, 'CZ') <> 0
    THEN 'Tschechien'
    WHEN STRPOS(country_ticket_id, 'HR') <> 0
    THEN 'Kroatien'
    WHEN STRPOS(country_ticket_id, 'CH') <> 0
    THEN 'Schweiz'
    WHEN STRPOS(country_ticket_id, 'SI') <> 0
    THEN 'Slowenien'
    WHEN STRPOS(country_ticket_id, 'FR') <> 0
    THEN 'Frankreich'
    WHEN STRPOS(country_ticket_id, 'HU') <> 0
    THEN 'Ungarn'
    WHEN STRPOS(country_ticket_id, 'AT') <> 0
    THEN 'Oesterreich'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') = 0
    THEN 'Polen'
    WHEN STRPOS(country_ticket_id, 'BG') <> 0
    THEN 'Bulgarien'
    WHEN STRPOS(country_ticket_id, 'CS') <> 0
    THEN 'Kanarische-Inseln'
    WHEN STRPOS(country_ticket_id, 'US') <> 0
    THEN 'USA'
    WHEN STRPOS(country_ticket_id, 'SE') <> 0
    THEN 'Schweden'
    WHEN STRPOS(country_ticket_id, 'SK') <> 0
    THEN 'Slowakei'
    WHEN STRPOS(country_ticket_id, 'RS_1') <> 0
    THEN 'Serbien'
    WHEN STRPOS(country_ticket_id, 'RO') <> 0
    THEN 'Rumaenien'
    WHEN STRPOS(country_ticket_id, 'IE') <> 0
    THEN 'Irland'
    WHEN STRPOS(country_ticket_id, 'NL') <> 0
    THEN 'Niederlande'
    WHEN STRPOS(country_ticket_id, 'LT') <> 0
    THEN 'Litauen'
    WHEN STRPOS(country_ticket_id, 'LV') <> 0
    THEN 'Lettland'
    WHEN country_ticket_id LIKE 'S' OR country_ticket_id LIKE 'S-HQ'
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'EE') <> 0
    THEN 'Estland'
    ELSE NULL
    END = 'Stiftung inkl. Schwarz IT'
  THEN CONCAT('<span>',
   '<img src="../images/lidl/BCBI/Länderflaggen/schwarz_logo.jpg"\\n            style="width:25px;margin-right:15px;padding-top:5px"/> Stiftung inkl. Schwarz IT\\n            </span>'
   )
  ELSE CONCAT('<span>', '<img src="../images/lidl/BCBI/Länderflaggen/Flaggen_RGB_', CASE
    WHEN STRPOS(country_ticket_id, 'MT') <> 0
    THEN 'Malta'
    WHEN STRPOS(country_ticket_id, 'ES') <> 0
    THEN 'Spanien'
    WHEN STRPOS(country_ticket_id, 'IT') <> 0
    THEN 'Italien'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') = 0
    THEN 'Deutschland'
    WHEN STRPOS(country_ticket_id, 'CY') <> 0
    THEN 'Zypern'
    WHEN STRPOS(country_ticket_id, 'NI') <> 0
    THEN 'Nordirland'
    WHEN STRPOS(country_ticket_id, 'GR') <> 0
    THEN 'Griechenland'
    WHEN STRPOS(country_ticket_id, 'DK') <> 0
    THEN 'Daenemark'
    WHEN STRPOS(country_ticket_id, 'BE') <> 0
    THEN 'Belgien'
    WHEN STRPOS(country_ticket_id, 'PT') <> 0
    THEN 'Portugal'
    WHEN STRPOS(country_ticket_id, 'FI') <> 0
    THEN 'Finnland'
    WHEN STRPOS(country_ticket_id, 'GB') <> 0
    THEN 'Grossbritannien'
    WHEN STRPOS(country_ticket_id, 'CZ') <> 0
    THEN 'Tschechien'
    WHEN STRPOS(country_ticket_id, 'HR') <> 0
    THEN 'Kroatien'
    WHEN STRPOS(country_ticket_id, 'CH') <> 0
    THEN 'Schweiz'
    WHEN STRPOS(country_ticket_id, 'SI') <> 0
    THEN 'Slowenien'
    WHEN STRPOS(country_ticket_id, 'FR') <> 0
    THEN 'Frankreich'
    WHEN STRPOS(country_ticket_id, 'HU') <> 0
    THEN 'Ungarn'
    WHEN STRPOS(country_ticket_id, 'AT') <> 0
    THEN 'Oesterreich'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') = 0
    THEN 'Polen'
    WHEN STRPOS(country_ticket_id, 'BG') <> 0
    THEN 'Bulgarien'
    WHEN STRPOS(country_ticket_id, 'CS') <> 0
    THEN 'Kanarische-Inseln'
    WHEN STRPOS(country_ticket_id, 'US') <> 0
    THEN 'USA'
    WHEN STRPOS(country_ticket_id, 'SE') <> 0
    THEN 'Schweden'
    WHEN STRPOS(country_ticket_id, 'SK') <> 0
    THEN 'Slowakei'
    WHEN STRPOS(country_ticket_id, 'RS_1') <> 0
    THEN 'Serbien'
    WHEN STRPOS(country_ticket_id, 'RO') <> 0
    THEN 'Rumaenien'
    WHEN STRPOS(country_ticket_id, 'IE') <> 0
    THEN 'Irland'
    WHEN STRPOS(country_ticket_id, 'NL') <> 0
    THEN 'Niederlande'
    WHEN STRPOS(country_ticket_id, 'LT') <> 0
    THEN 'Litauen'
    WHEN STRPOS(country_ticket_id, 'LV') <> 0
    THEN 'Lettland'
    WHEN country_ticket_id LIKE 'S' OR country_ticket_id LIKE 'S-HQ'
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'EE') <> 0
    THEN 'Estland'
    ELSE NULL
    END, '.png" style="width:25px;margin-right:15px;padding-top:5px"/>', CASE
    WHEN STRPOS(country_ticket_id, 'MT') <> 0
    THEN 'Malta'
    WHEN STRPOS(country_ticket_id, 'ES') <> 0
    THEN 'Spanien'
    WHEN STRPOS(country_ticket_id, 'IT') <> 0
    THEN 'Italien'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'DE') <> 0 AND STRPOS(opened_by_group, 'int') = 0
    THEN 'Deutschland'
    WHEN STRPOS(country_ticket_id, 'CY') <> 0
    THEN 'Zypern'
    WHEN STRPOS(country_ticket_id, 'NI') <> 0
    THEN 'Nordirland'
    WHEN STRPOS(country_ticket_id, 'GR') <> 0
    THEN 'Griechenland'
    WHEN STRPOS(country_ticket_id, 'DK') <> 0
    THEN 'Daenemark'
    WHEN STRPOS(country_ticket_id, 'BE') <> 0
    THEN 'Belgien'
    WHEN STRPOS(country_ticket_id, 'PT') <> 0
    THEN 'Portugal'
    WHEN STRPOS(country_ticket_id, 'FI') <> 0
    THEN 'Finnland'
    WHEN STRPOS(country_ticket_id, 'GB') <> 0
    THEN 'Grossbritannien'
    WHEN STRPOS(country_ticket_id, 'CZ') <> 0
    THEN 'Tschechien'
    WHEN STRPOS(country_ticket_id, 'HR') <> 0
    THEN 'Kroatien'
    WHEN STRPOS(country_ticket_id, 'CH') <> 0
    THEN 'Schweiz'
    WHEN STRPOS(country_ticket_id, 'SI') <> 0
    THEN 'Slowenien'
    WHEN STRPOS(country_ticket_id, 'FR') <> 0
    THEN 'Frankreich'
    WHEN STRPOS(country_ticket_id, 'HU') <> 0
    THEN 'Ungarn'
    WHEN STRPOS(country_ticket_id, 'AT') <> 0
    THEN 'Oesterreich'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') <> 0
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'PL') <> 0 AND STRPOS(opened_by_group, 'ldl-int') = 0
    THEN 'Polen'
    WHEN STRPOS(country_ticket_id, 'BG') <> 0
    THEN 'Bulgarien'
    WHEN STRPOS(country_ticket_id, 'CS') <> 0
    THEN 'Kanarische-Inseln'
    WHEN STRPOS(country_ticket_id, 'US') <> 0
    THEN 'USA'
    WHEN STRPOS(country_ticket_id, 'SE') <> 0
    THEN 'Schweden'
    WHEN STRPOS(country_ticket_id, 'SK') <> 0
    THEN 'Slowakei'
    WHEN STRPOS(country_ticket_id, 'RS_1') <> 0
    THEN 'Serbien'
    WHEN STRPOS(country_ticket_id, 'RO') <> 0
    THEN 'Rumaenien'
    WHEN STRPOS(country_ticket_id, 'IE') <> 0
    THEN 'Irland'
    WHEN STRPOS(country_ticket_id, 'NL') <> 0
    THEN 'Niederlande'
    WHEN STRPOS(country_ticket_id, 'LT') <> 0
    THEN 'Litauen'
    WHEN STRPOS(country_ticket_id, 'LV') <> 0
    THEN 'Lettland'
    WHEN country_ticket_id LIKE 'S' OR country_ticket_id LIKE 'S-HQ'
    THEN 'Stiftung inkl. Schwarz IT'
    WHEN STRPOS(country_ticket_id, 'EE') <> 0
    THEN 'Estland'
    ELSE NULL
    END, '</span>')
  END AS country_flag_img_name,
 opened_by_group
FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_daily_1;