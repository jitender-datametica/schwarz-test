select distinct mandant_id,sap_mwst_id, mwst_id, dat_von, dat_bis 
from DBP_DATA.mwst_per 
/*
GROUP BY mandant_id,sap_mwst_id 
QUALIFY CSUM(1, dat_bis DESC) = 1 order by mandant_id, sap_mwst_id desc;
*/
qualify row_number() over (partition by mandant_id,sap_mwst_id  order by mandant_id, sap_mwst_id desc)=1;
