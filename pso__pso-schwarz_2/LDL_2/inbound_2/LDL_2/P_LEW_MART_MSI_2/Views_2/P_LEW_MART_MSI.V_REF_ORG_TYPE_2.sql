CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ORG_TYPE_2(	
      org_type_id    -- ID der Organisationsebene                                                                                                                     	
    , org_type_desc  -- Beschreibung der Organisationsebene                                                                                                                   	
    , dat_dayend     -- Datum der ""Datenerzeugung""                                                                                                                   	
    , load_id       -- ID der Beladung                                                                                                                    	
)	
AS	
   SELECT	
         t.org_type_id,	
   t.org_type_desc,	
   t.dat_dayend,	
   t.load_id	
   FROM p_lew_core_ac.v_wawi_ref_org_type_2 AS t;