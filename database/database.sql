DROP DATABASE IF EXISTS dbPDV;
CREATE DATABASE dbPDV;
USE dbPDV;

CREATE TABLE tblLogin 
(
    cdLogin    INTEGER,
    nmEmail    CHAR(100) NOT NULL UNIQUE,
    nmUser     CHAR(100) NOT NULL UNIQUE,
    nmPassword CHAR(100) NOT NULL,
	dsType     CHAR(20)  NOT NULL,
	dsStatus   CHAR(20)  NOT NULL
);

ALTER TABLE tblLogin
ADD CONSTRAINT PK_Login PRIMARY KEY (cdLogin);

ALTER TABLE tblLogin
ADD CONSTRAINT FK_User_Login
FOREIGN KEY (cd_User) REFERENCES tblUser (cdUser);

ALTER TABLE tblLogin
MODIFY cdLogin INTEGER AUTO_INCREMENT;

INSERT INTO tblLogin (nmEmail,nmUser,nmPassword,dsType,dsStatus) VALUES ("admin@gmail.com","admin","1234567","Administrador","Ativo");
INSERT INTO tblLogin (nmEmail,nmUser,nmPassword,dsType,dsStatus) VALUES ("wickdias@gmail.com","wick_dias","1234567","Funcionário","Ativo");

CREATE TABLE tblCashier
(
    cdCashier  INTEGER,
	opening    BOOLEAN NOT NULL,
    closing    BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

select * from tblcashier;

ALTER TABLE tblCashier
ADD CONSTRAINT PK_Cashier_Cashier PRIMARY KEY (cdCashier);

ALTER TABLE tblCashier
MODIFY cdCashier  INTEGER AUTO_INCREMENT;

CREATE TABLE tblCashierLogin
(
	cdCashierLogin INTEGER,
    cdLogin        INTEGER NOT NULL,
    cdCashier      INTEGER NOT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE tblCashierLogin
ADD CONSTRAINT PK_Login_Cashier PRIMARY KEY (cdCashierLogin);

ALTER TABLE tblCashierLogin
MODIFY cdCashierLogin  INTEGER AUTO_INCREMENT;

CREATE TABLE tblAddress
(
    noCep      NUMERIC(8)   NOT NULL,  
    nmLogra    VARCHAR(100) NOT NULL,
    nmBairro   VARCHAR(100) NOT NULL,
    nmCidade   VARCHAR(100) NOT NULL,
    sgUf       CHAR(2)      NOT NULL DEFAULT 'SP'
);

ALTER TABLE tblAddress
ADD CONSTRAINT PK_CEP_Address PRIMARY KEY (noCep);

CREATE TABLE tblProvider
(
    cdProvider   INTEGER,
    nmName       CHAR(255)   NOT NULL,
    noCNPJ       NUMERIC(14) NOT NULL,
    noCEP        NUMERIC(8)  NOT NULL,
    noAddress    NUMERIC(8)  NOT NULL,
    nmEmail      CHAR(100)   NOT NULL,
    noCellphone  NUMERIC(14) NOT NULL
);

ALTER TABLE tblProvider
ADD CONSTRAINT PK_Provider_Provider PRIMARY KEY (cdProvider);

ALTER TABLE tblProvider
MODIFY cdProvider  INTEGER AUTO_INCREMENT;

ALTER TABLE tblProvider
ADD CONSTRAINT FK_Address_Provider
FOREIGN KEY (noCEP) REFERENCES tblAddress(noCEP);

CREATE TABLE tblProduct
(
    cdProduct        INTEGER,
    noBarCode        CHAR(100)  NOT NULL,
    nmDescription    CHAR(100)  NOT NULL,
    dtExpirationDate DATE       NOT NULL,
    noAmountPaid     DECIMAL(6) NOT NULL,
    noSaleValue      DECIMAL(6) NOT NULL,
    noProfit         DECIMAL(6) NOT NULL,
    noQuantity       INT        NOT NULL
);

-- UPDATE tblProduct
-- SET noBarCode = ?, nmDescription = ?, dtExpirationDate = ?, noAmountPaid = ?, noSaleValue = ?,noProfit = ?, noQuantity = ?
-- WHERE cdProduct = ?;

ALTER TABLE tblProduct
ADD CONSTRAINT PK_Product_Product PRIMARY KEY (cdProduct);

ALTER TABLE tblProduct
MODIFY cdProduct  INTEGER AUTO_INCREMENT;

CREATE TABLE tblProviderProduct
(
    cdProvider INTEGER,
    cdProduct  INTEGER,
    PRIMARY KEY(cdProvider,cdProduct) 
);

CREATE TABLE tblClient
(
    cdClient     INTEGER,
    nmName       CHAR(255)   NOT NULL,
    noCPF        NUMERIC(11) NOT NULL,
    noCEP        NUMERIC(8)  NOT NULL,
    noAddress    NUMERIC(8)  NOT NULL,
    nmEmail      CHAR(100)   NOT NULL,
    noCellphone  NUMERIC(14) NOT NULL
);

ALTER TABLE tblClient
ADD CONSTRAINT PK_Client_Client PRIMARY KEY (cdClient);

ALTER TABLE tblClient
MODIFY cdClient  INTEGER AUTO_INCREMENT;

ALTER TABLE tblClient
ADD CONSTRAINT FK_Address_Client
FOREIGN KEY (noCEP) REFERENCES tblAddress(noCEP);

CREATE TABLE tblSale
(
    cdSale          INTEGER,
    cd_Login        INTEGER     NOT NULL,
    cd_Cashier      INTEGER     NOT NULL,
    noQuantityTotal INTEGER     NOT NULL,
    noTotalValue    DECIMAL(10) NOT NULL
);

ALTER TABLE tblSale
ADD CONSTRAINT PK_Sale_Sale PRIMARY KEY (cdSale);

ALTER TABLE tblSale
MODIFY cdSale  INTEGER AUTO_INCREMENT;

ALTER TABLE tblSale
ADD CONSTRAINT FK_Login_Sale
FOREIGN KEY (cd_Login) REFERENCES tblLogin(cdLogin);

ALTER TABLE tblSale
ADD CONSTRAINT FK_Cashier_Sale
FOREIGN KEY (cd_Cashier) REFERENCES tblCashier(cdCashier);

CREATE TABLE tblTypePay
(
    cdTypePay INTEGER,
    nmTypePay CHAR(100) NOT NULL
);

ALTER TABLE tblTypePay
ADD CONSTRAINT PK_TypePay_TypePay PRIMARY KEY (cdTypePay);

ALTER TABLE tblTypePay
MODIFY cdTypePay  INTEGER AUTO_INCREMENT;

CREATE TABLE tblTypeSale
(
    cdSale    INTEGER,
    cdTypePay INTEGER,
    PRIMARY KEY(cdSale,cdTypePay)
);

CREATE TABLE tblSaleProduct
(
    cdSaleProd INTEGER,
    cdSale     INTEGER,
    cdProduct  INTEGER,
    noValue    DECIMAL(8),
    noQuantity INTEGER
);

ALTER TABLE tblSaleProduct
ADD CONSTRAINT PK_SaleProduct_SaleProduct PRIMARY KEY (cdSaleProd);

ALTER TABLE tblSaleProduct
MODIFY cdSaleProd  INTEGER AUTO_INCREMENT;

ALTER TABLE tblSaleProduct
ADD CONSTRAINT FK_Sale_Product
FOREIGN KEY (cdSale) REFERENCES tblSale(cdSale);

ALTER TABLE tblSaleProduct
ADD CONSTRAINT FK_Product_Sale
FOREIGN KEY (cdProduct) REFERENCES tblProduct(cdProduct);

CREATE TABLE tblCompany
(
	cdCompany     INTEGER,
    nmCompany     CHAR(255)    NOT NULL,
    noCPNJCompany NUMERIC(14),
    noTelephone   NUMERIC(9),
    noCep         NUMERIC(8)   NOT NULL,  
    nmLogra       VARCHAR(100) NOT NULL,
    nmBairro      VARCHAR(100) NOT NULL,
    nmCidade      VARCHAR(100) NOT NULL,
    sgUf          CHAR(2)      NOT NULL DEFAULT 'SP'
);

ALTER TABLE tblCompany
ADD CONSTRAINT PK_Company_Company PRIMARY KEY (cdCompany);

ALTER TABLE tblCompany
MODIFY cdCompany  INTEGER AUTO_INCREMENT;

CREATE TABLE tblCoupon
(
    cdCoupon   INTEGER,
    cd_Sale    INTEGER  NOT NULL,
    cd_Company INTEGER  NOT NULL,
    cd_Client  INTEGER  NOT NULL,
    dtEmission DATETIME NOT NULL
);

ALTER TABLE tblCoupon
ADD CONSTRAINT PK_Coupon_Coupon PRIMARY KEY (cdCoupon);

ALTER TABLE tblCoupon
MODIFY cdCoupon  INTEGER AUTO_INCREMENT;

ALTER TABLE tblCoupon
ADD CONSTRAINT FK_Sale_Coupon
FOREIGN KEY (cd_Sale) REFERENCES tblSale(cdSale);

ALTER TABLE tblCoupon
ADD CONSTRAINT FK_Company_Coupon
FOREIGN KEY (cd_Company) REFERENCES tblCompany(cdCompany);

ALTER TABLE tblCoupon
ADD CONSTRAINT FK_Client_Coupon
FOREIGN KEY (cd_Client) REFERENCES tblClient(cdClient);

CREATE TABLE tblPayment
(
	cdPay      	   INTEGER,
    cd_TypePay 	   INTEGER     NOT NULL,
    cd_Sale    	   INTEGER     NOT NULL,
    noParcialValue DECIMAL(10) NOT NULL
);

ALTER TABLE tblPayment
ADD CONSTRAINT PK_Payment_Payment PRIMARY KEY (cdPay);

ALTER TABLE tblPayment
MODIFY cdPay  INTEGER AUTO_INCREMENT;

ALTER TABLE tblPayment
ADD CONSTRAINT FK_TypePay_Payment
FOREIGN KEY (cd_TypePay) REFERENCES tblTypePay(cdTypePay);

ALTER TABLE tblPayment
ADD CONSTRAINT FK_Sale_Payment
FOREIGN KEY (cd_Sale) REFERENCES tblSale(cdSale);




