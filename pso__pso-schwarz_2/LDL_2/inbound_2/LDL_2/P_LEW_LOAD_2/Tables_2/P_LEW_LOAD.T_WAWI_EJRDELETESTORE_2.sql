
CREATE OR REPLACE TRANSIENT TABLE P_LEW_LOAD.t_wawi_ejrdeletestore_2 
     (
      system_key NUMBER(10,0) NOT NULL,
      client_id NUMBER(3,0) NOT NULL,
      store_id NUMBER(10,0) NOT NULL,
      dat_formdate DATE  NOT NULL,
      dat_dayend DATE  NOT NULL,
      client_id2 NUMBER(10,0),
      st_loc_sid NUMBER(10,0))
      ;