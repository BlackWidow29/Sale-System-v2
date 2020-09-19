package br.com.mnbebidas.entities;

public class SaleSession {
	
	private static SaleSession instance;
	
	private int cdSale;
	
	private SaleSession(int cdSale) {
		this.cdSale = cdSale;
	}
	
	public static SaleSession getInstance(int cdSale) {
		if (instance == null) {
            instance = new SaleSession(cdSale);
        }
		else
		{
			instance.setCdSale(cdSale);
		}
        return instance;
	}
	
    public static SaleSession getInstance() throws IllegalStateException {
		if (instance == null) {
			//Gera uma sess�o se os dados dela forem obtidos antes da sua inicializa��o
			throw new IllegalStateException("Sess�o da venda n�o foi inicializada");
		}
        return instance;
    }

	public int getCdSale() {
		return cdSale;
	}

	public void setCdSale(int cdSale) {
		this.cdSale = cdSale;
	}
	
	
}
