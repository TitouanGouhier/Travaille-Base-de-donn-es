#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: type_avion
#------------------------------------------------------------

CREATE TABLE type_avion(
        id_type_avion             Int  Auto_increment  NOT NULL ,
        modele_type_avion         Varchar (20) NOT NULL ,
        constructeur_type_avion   Varchar (20) NOT NULL ,
        nombre_place_totale_avion Int NOT NULL
	,CONSTRAINT type_avion_PK PRIMARY KEY (id_type_avion)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: avion
#------------------------------------------------------------

CREATE TABLE avion(
        id_avion          Int  Auto_increment  NOT NULL ,
        affectation_avion Varchar (15) NOT NULL ,
        code_avion        Varchar (20) NOT NULL ,
        id_type_avion     Int NOT NULL
	,CONSTRAINT avion_PK PRIMARY KEY (id_avion)

	,CONSTRAINT avion_type_avion_FK FOREIGN KEY (id_type_avion) REFERENCES type_avion(id_type_avion)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: classe
#------------------------------------------------------------

CREATE TABLE classe(
        id_classe      Int  Auto_increment  NOT NULL ,
        libelle_classe Varchar (20) NOT NULL
	,CONSTRAINT classe_PK PRIMARY KEY (id_classe)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: ville
#------------------------------------------------------------

CREATE TABLE ville(
        id_ville  Int  Auto_increment  NOT NULL ,
        nom_ville Varchar (40) NOT NULL
	,CONSTRAINT ville_PK PRIMARY KEY (id_ville)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: aeroport
#------------------------------------------------------------

CREATE TABLE aeroport(
        id_aeroport         Int  Auto_increment  NOT NULL ,
        nbr_total_terminaux Int NOT NULL ,
        nbr_total_portes    Int NOT NULL ,
        id_ville            Int NOT NULL
	,CONSTRAINT aeroport_PK PRIMARY KEY (id_aeroport)

	,CONSTRAINT aeroport_ville_FK FOREIGN KEY (id_ville) REFERENCES ville(id_ville)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: vol
#------------------------------------------------------------

CREATE TABLE vol(
        id_vol                   Int  Auto_increment  NOT NULL ,
        numero_vol               Int NOT NULL ,
        date_vol                 Date NOT NULL ,
        horaire_depart_vol       Time NOT NULL ,
        horaire_embarquement_vol Time NOT NULL ,
        horaire_arrivee_vol      Time NOT NULL ,
        terminal_depart_vol      Varchar (4) NOT NULL ,
        porte_depart_vol         Varchar (4) NOT NULL ,
        terminal_arrivee_vol     Varchar (4) NOT NULL ,
        id_aeroport              Int NOT NULL ,
        id_aeroport_atterrit     Int NOT NULL
	,CONSTRAINT vol_PK PRIMARY KEY (id_vol)

	,CONSTRAINT vol_aeroport_FK FOREIGN KEY (id_aeroport) REFERENCES aeroport(id_aeroport)
	,CONSTRAINT vol_aeroport0_FK FOREIGN KEY (id_aeroport_atterrit) REFERENCES aeroport(id_aeroport)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: pilote
#------------------------------------------------------------

CREATE TABLE pilote(
        id_pilote             Int  Auto_increment  NOT NULL ,
        nom_pilote            Varchar (20) NOT NULL ,
        prenom_pilote         Varchar (20) NOT NULL ,
        date_naissance_pilote Date NOT NULL ,
        date_embauche_pilote  Date NOT NULL ,
        grade_pilote          Varchar (20) NOT NULL ,
        id_ville              Int NOT NULL
	,CONSTRAINT pilote_PK PRIMARY KEY (id_pilote)

	,CONSTRAINT pilote_ville_FK FOREIGN KEY (id_ville) REFERENCES ville(id_ville)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: contient
#------------------------------------------------------------

CREATE TABLE contient(
        id_classe           Int NOT NULL ,
        id_type_avion       Int NOT NULL ,
        nombre_place_classe Int NOT NULL
	,CONSTRAINT contient_PK PRIMARY KEY (id_classe,id_type_avion)

	,CONSTRAINT contient_classe_FK FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
	,CONSTRAINT contient_type_avion0_FK FOREIGN KEY (id_type_avion) REFERENCES type_avion(id_type_avion)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: affecte
#------------------------------------------------------------

CREATE TABLE affecte(
        id_vol    Int NOT NULL ,
        id_avion  Int NOT NULL ,
        id_pilote Int NOT NULL
	,CONSTRAINT affecte_PK PRIMARY KEY (id_vol,id_avion,id_pilote)

	,CONSTRAINT affecte_vol_FK FOREIGN KEY (id_vol) REFERENCES vol(id_vol)
	,CONSTRAINT affecte_avion0_FK FOREIGN KEY (id_avion) REFERENCES avion(id_avion)
	,CONSTRAINT affecte_pilote1_FK FOREIGN KEY (id_pilote) REFERENCES pilote(id_pilote)
)ENGINE=InnoDB;

#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: employe
#------------------------------------------------------------

CREATE TABLE employe(
        id_employe         Int  Auto_increment  NOT NULL ,
        nom_employe        Varchar (20) NOT NULL ,
        prenom_employe     Varchar (20) NOT NULL ,
        salaire_employe    Float NOT NULL ,
        commission_employe Float NOT NULL
	,CONSTRAINT employe_PK PRIMARY KEY (id_employe)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: client
#------------------------------------------------------------

CREATE TABLE client(
        id_client     Int  Auto_increment  NOT NULL ,
        nom_client    Varchar (20) NOT NULL ,
        prenom_client Varchar (20) NOT NULL
	,CONSTRAINT client_PK PRIMARY KEY (id_client)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: reduction
#------------------------------------------------------------

CREATE TABLE reduction(
        id_reduction          Int  Auto_increment  NOT NULL ,
        libelle_reduction     Varchar (20) NOT NULL ,
        pourcentage_reduction Float NOT NULL
	,CONSTRAINT reduction_PK PRIMARY KEY (id_reduction)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: reservation
#------------------------------------------------------------

CREATE TABLE reservation(
        id_reservation   Int  Auto_increment  NOT NULL ,
        date_reservation Date NOT NULL ,
        prix_reservation Float NOT NULL ,
        id_reduction     Int ,
        id_employe       Int NOT NULL ,
        id_client        Int NOT NULL ,
        id_classe        Int NOT NULL
	,CONSTRAINT reservation_PK PRIMARY KEY (id_reservation)

	,CONSTRAINT reservation_reduction_FK FOREIGN KEY (id_reduction) REFERENCES reduction(id_reduction)
	,CONSTRAINT reservation_employe0_FK FOREIGN KEY (id_employe) REFERENCES employe(id_employe)
	,CONSTRAINT reservation_client1_FK FOREIGN KEY (id_client) REFERENCES client(id_client)
	,CONSTRAINT reservation_classe2_FK FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: voyageur
#------------------------------------------------------------

CREATE TABLE voyageur(
        id_voyageur             Varchar (9) NOT NULL ,
        nom_voyageur            Varchar (20) NOT NULL ,
        prenom_voyageur         Varchar (20) NOT NULL ,
        date_naissance_voyageur Date NOT NULL ,
        id_reservation          Int NOT NULL,
		id_vol Int NOT NULL
	,CONSTRAINT voyageur_PK PRIMARY KEY (id_voyageur)
	,CONSTRAINT voyageur_vol_FK FOREIGN KEY (id_vol) REFERENCES vol(id_vol)
	,CONSTRAINT voyageur_reservation_FK FOREIGN KEY (id_reservation) REFERENCES reservation(id_reservation)
)ENGINE=InnoDB;


