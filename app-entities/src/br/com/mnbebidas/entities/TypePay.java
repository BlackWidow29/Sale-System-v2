package br.com.mnbebidas.entities;

public class TypePay {
	
	private static TypePay instance;
	private int cdTypePay;
	private String nmTypePay;

	private TypePay(int cdTypePay,String nmTypePay) {
		this.cdTypePay = cdTypePay;
		this.nmTypePay = nmTypePay;
	}
	
	public static TypePay getInstance(int cdTypePay,String nmTypePay) {
		if(instance == null) {
			instance = new TypePay(cdTypePay,nmTypePay);
		}
		else {
			instance.setCdTypePay(cdTypePay);
			instance.setNmTypePay(nmTypePay);
		}
		
		return instance;
	}
	
    public static TypePay getInstance() throws IllegalStateException {
		if (instance == null) {
			//Gera uma sess�o se os dados dela forem obtidos antes da sua inicializa��o
			throw new IllegalStateException("Sess�o do tipo de pagamento n�o foi inicializada");
		}
        return instance;
    }

	public int getCdTypePay() {
		return cdTypePay;
	}

	public void setCdTypePay(int cdTypePay) {
		this.cdTypePay = cdTypePay;
	}

	public String getNmTypePay() {
		return nmTypePay;
	}

	public void setNmTypePay(String nmTypePay) {
		this.nmTypePay = nmTypePay;
	}

}
