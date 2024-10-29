import javax.persistence.*;

@Entity
public class Categoria {
    @Id
    private int id;
    private String tipo;
    private String nome;
    private String descricao;

}

import javax.persistence.*;

@Entity
public class FormaPagamento {
    @Id
    private int id;
    private String tipoPagamento;

}

import javax.persistence.*;

@Entity
public class Produto {
    @Id
    private int idProduto;
    private String nome;
    private String descricao;
    private double preco;

    @ManyToOne
    @JoinColumn(name = "categoria_id")
    private Categoria categoria;

    @ManyToOne
    @JoinColumn(name = "restaurante_id")
    private Restaurante restaurante;

}

import javax.persistence.*;

@Entity
public class Restaurante {
    @Id
    private int id;
    private String nome;
    private String endereco;
    private String telefone;
    private String categoria;
    private String horaFuncionamento;
    private boolean isRetirada;

}

import javax.persistence.*;

@Entity
public class Pedido {
    @Id
    private int id;
    private Date data;
    private double valor;
    private double taxaEntrega;
    private String obs;
    private double troco;

    @ManyToOne
    @JoinColumn(name = "idResta")
    private Restaurante restaurante;

    @ManyToOne
    @JoinColumn(name = "idFormaPag")
    private FormaPagamento formaPagamento;

    @ManyToOne
    @JoinColumn(name = "idEndereco")
    private Endereco endereco;

}
