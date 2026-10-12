CREATE OR REPLACE view P_LEW_BIL.V_MAT_LOCATION_ORGANIZATION as
   SELECT  loc_org.client_id,	
   loc_org.loc_sid_exp AS loc_sid_wh,	
   loc_org.loc_sid       AS loc_sid_store,	
   loc_org.sales_manager_id,	
   loc_org.sales_manager_name,	
   loc_org.account_manager_id,	
   loc_org.account_manager_name,	
   loc_org.general_manager_id,	
   loc_org.general_manager_name,	
   loc_org.organisation_id,	
   loc_org.district_cd,	
   loc_org.active_from_dt,	
   loc_org.active_to_dt,	
   loc_org.deleted_fg,	
   loc_org.dwh_valid_from,	
   loc_org.dwh_valid_to,	
   CASE	
                  WHEN CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to	
                  THEN 1 ELSE 0 END AS dwh_actual_fg,	
   CASE	
                  WHEN deleted_fg = 0 AND CURRENT_DATE BETWEEN active_from_dt AND COALESCE(active_to_dt, '9999-12-31')	
                  THEN 1 ELSE 0 END AS active_fg	
    FROM p_lew_core_ac.v_location_organization_hist AS loc_org	
   INNER JOIN p_lew_core_ac.v_location AS loc	
   ON   loc_org.client_id = loc.client_id	
   AND loc_org.loc_sid_exp = loc.loc_sid	
   AND loc.wh_store_mark = 'B'	
	
 WHERE --Es werden nur ungelöschte WHs betrachtet	
         loc_org.deleted_fg = 0	
       -- Es werden nur Organisations-Zeilen i.S.v. STORE zu WH - Zuordnungen betrachtet, deren aktuellste Version als ungelöscht markiert vorliegt.	
       -- M.a.W: Organisationszeilen zu STORE2WH-Kombinationen, deren aktuellste Zeile als gelöscht markiert ist, sind grundsätzlich auszublenden, denn deren Werte	
       -- beziehen sich auf mutmaßlich vergangene und damit nicht mehr existente Store-WH-Kombis.	
   AND (loc_org.client_id, loc_org.loc_sid_exp, loc_org.loc_sid)	
            IN ( SELECT stm.client_id,	
   stm.loc_sid_exp,	
   stm.loc_sid	
                    FROM p_lew_core_ac.v_location_organization_hist AS stm	
   WHERE Current_Date BETWEEN stm.dwh_valid_from AND stm.dwh_valid_to	
     AND stm.deleted_fg = 0	
 )	
  -- Bislang haben wir die nun gewonnenen Result-Menge ohne Einschränkung der Zeit betrachtet. Einfach nur die akuellste Zeile zu wählen wäre zwar prinzipiell richtig,	
  -- entspricht aber offenbar nicht den Erfahrungen, die im ECO-DWH mit der dieser Entität zugrundeliegenden Quelle gesammelt wurden.	
  -- Scheinbar wurden im Quellsystem teilweise Dummies vergeben für nicht mehr bekannte Sales-Manager / Account-Manager / General-Manager.	
  -- Im Sinne einer (modifizierten) last-known-Betrachtung wird nun der aktuellste Realmanager (Nicht-Dummy) herangezogen, um diesen in der Ergebniszeile auzuweisen.	
  -- In diesem Sinne wird dem tieferen Sinne zwar schon der aktuelle Satz ausgewiesen, wobei der Bedeutungsinhalt von ""Aktualität"" hier ungewöhnlich belegt wurde.	
  -- Die Vorlage diese Business-Layer-Entität wurde aus der Abstraktion der Nachbauten für den BDO-COEX-MART entnommen. Dort liegen Einzelentitäten getrennt für Sales-Manager und Account-Manager	
  -- vor. Die dort vorgenommene Row-Order richtet sich demzufolge einmal danaach, ob der Sales-Manager eine Dummy ist oder eben der Account-Manager.	
  -- Da nach Sichtung der Daten festgestellt wurde, daß alle vorliegenden Zeilen bei einem SALES-Manager=DUMMY auch den ausgewiesenen Account-Manager als Dummy ausweisen, wurde die hier	
  -- vorliegende gemeinschaftliche Darstellung auf den SALES-MANAGER reduziert. M.a.W: Sales-Manager ist DUMMY => der Satz ist eine DUMMY-Satz.	
QUALIFY Row_Number() Over (PARTITION BY loc_org.client_id, loc_org.loc_sid_exp, loc_org.loc_sid	
              ORDER BY CASE WHEN loc_org.sales_manager_id <> -100	
                            THEN 'Nicht-Dummies'	
                            ELSE 'Dummies'	
                       END DESC NULLS LAST	
                       ,loc_org.dwh_valid_to DESC NULLS LAST) = 1	
;