CREATE TABLE Categoria (
    id INT PRIMARY KEY,
    tipo VARCHAR(50),
    nome VARCHAR(50),
    descricao VARCHAR(255)
);

CREATE TABLE FormaPagamento (
    id INT PRIMARY KEY,
    tipo_pagamento VARCHAR(50)
);

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(255),
    preco DECIMAL(10, 2),
    categoria_id INT,
    restaurante_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(id),
    FOREIGN KEY (restaurante_id) REFERENCES Restaurante(id)
);

CREATE TABLE Restaurante (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    categoria VARCHAR(50),
    hora_funcionamento TIME,
    is_retirada BOOLEAN
);

CREATE TABLE Pedido (
    id INT PRIMARY KEY,
    data DATE,
    id_resta INT,
    valor DECIMAL(10, 2),
    taxa_entrega DECIMAL(10, 2),
    id_promo INT,
    id_status_entrega INT,
    id_forma_pagamento INT,
    obs TEXT,
    troco DECIMAL(10, 2),
    id_endereco INT,
    FOREIGN KEY (id_resta) REFERENCES Restaurante(id),
    FOREIGN KEY (id_promo) REFERENCES Promo(id),
    FOREIGN KEY (id_status_entrega) REFERENCES StatusEntrega(id),
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id),
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id)
);

CREATE TABLE PedidoProduto (
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE Acompanhamento (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(255),
    valor DECIMAL(10, 2)
);

CREATE TABLE PedidoProdutoAcomp (
    id_pedido_produto INT,
    id_acomp INT,
    PRIMARY KEY (id_pedido_produto, id_acomp),
    FOREIGN KEY (id_pedido_produto) REFERENCES PedidoProduto(id_pedido),
    FOREIGN KEY (id_acomp) REFERENCES Acompanhamento(id)
);

CREATE TABLE Endereco (
    id INT PRIMARY KEY,
    rua VARCHAR(100),
    numero INT,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    cep VARCHAR(20),
    complemento VARCHAR(50)
);

CREATE TABLE Promo (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    valor DECIMAL(10, 2),
    codigo VARCHAR(50),
    validade DATE
);

CREATE TABLE StatusEntrega (
    id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE Avaliacao (
    id INT PRIMARY KEY,
    nota INT,
    pedido_id INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id)
);

CREATE TABLE HistoricoPagamento (
    id INT PRIMARY KEY,
    data DATE,
    valor DECIMAL(10, 2)
);

CREATE TABLE ProdAcomp (
    id_produto INT,
    id_acomp INT,
    PRIMARY KEY (id_produto, id_acomp),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_acomp) REFERENCES Acompanhamento(id)
);

CREATE TABLE HistoricoEntrega (
    id INT PRIMARY KEY,
    id_status_entrega INT,
    id_pedido INT,
    data_hora TIMESTAMP,
    FOREIGN KEY (id_status_entrega) REFERENCES StatusEntrega(id),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id)
);
