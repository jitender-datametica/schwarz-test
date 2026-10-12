CREATE OR REPLACE VIEW P_LEW_BIL.V_EXCHANGE_RATE_REPORT_ASIS as
   -- Es wird pro CLIENT min. ein Satz zurückgegeben. Ein Wechselkurs ist immer von der Nationalwährung zur Nationalwährung (Wechselkurs 1,0) vorhanden.
   -- Falls die Nationalwährung nicht EURO ist, wird zudem der Wechselkurs von EURO zu Nationalwährung angezeigt.
   SELECT  erkh.client_id,
   erkh.curr_sid_from,
   erkh.curr_sid_to,
   erkh.curr_cd_from,
   erkh.curr_cd_to,
   erkh.exchange_rate
  FROM p_lew_core_ac.v_exchange_rate_known_hist AS erkh
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS ert
   ON erkh.client_id = ert.client_id
   AND erkh.x_rate_type_sid = ert.x_rate_type_sid
-- nur aktuell bekannte Kurse
WHERE Current_Date BETWEEN erkh.dwh_valid_from AND erkh.dwh_valid_to
-- Nur aktuell fachlich gültige Kurse
AND Current_Date BETWEEN erkh.active_from_dt AND erkh.active_to_dt
-- Keine gelöschten Kurse
AND erkh.deleted_fg = 0
--UND nur die Berichtswesen-Kurse, diese werden extern geliefert als File und gelten als aktiv für einen langen Zeitraum:
-- Berichtswesenkurse werden einmal am Anfang des Geschäftsjahres festgelegt und gelten für ein Jahr. Damit werden keine tägliche Währungskurse betrachtet.
AND UPPER(ert.src_kurst) = '@BEWE'
   ;