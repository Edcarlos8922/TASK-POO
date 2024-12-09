CREATE TABLE Categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE FormaPagamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_pagamento VARCHAR(50) NOT NULL
);

CREATE TABLE Restaurante (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    categoria VARCHAR(50),
    hora_funcionamento TIME NOT NULL,
    is_retirada BOOLEAN NOT NULL
);

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10, 2) NOT NULL,
    categoria_id INT NOT NULL,
    restaurante_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(id),
    FOREIGN KEY (restaurante_id) REFERENCES Restaurante(id)
);

CREATE TABLE Promo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    valor DECIMAL(10, 2),
    codigo VARCHAR(50),
    validade DATE
);

CREATE TABLE StatusEntrega (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Endereco (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    cep VARCHAR(20),
    complemento VARCHAR(50)
);

CREATE TABLE Pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    id_resta INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    taxa_entrega DECIMAL(10, 2),
    id_promo INT,
    id_status_entrega INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    obs TEXT,
    troco DECIMAL(10, 2),
    id_endereco INT NOT NULL,
    FOREIGN KEY (id_resta) REFERENCES Restaurante(id),
    FOREIGN KEY (id_promo) REFERENCES Promo(id),
    FOREIGN KEY (id_status_entrega) REFERENCES StatusEntrega(id),
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id),
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id)
);

CREATE TABLE PedidoProduto (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Acompanhamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    valor DECIMAL(10, 2)
);

CREATE TABLE PedidoProdutoAcomp (
    id_pedido INT,
    id_produto INT,
    id_acomp INT,
    PRIMARY KEY (id_pedido, id_produto, id_acomp),
    FOREIGN KEY (id_pedido, id_produto) REFERENCES PedidoProduto(id_pedido, id_produto),
    FOREIGN KEY (id_acomp) REFERENCES Acompanhamento(id)
);

CREATE TABLE Avaliacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
    pedido_id INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id)
);

CREATE TABLE HistoricoPagamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ProdAcomp (
    id_produto INT,
    id_acomp INT,
    PRIMARY KEY (id_produto, id_acomp),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_acomp) REFERENCES Acompanhamento(id)
);

CREATE TABLE HistoricoEntrega (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_status_entrega INT NOT NULL,
    id_pedido INT NOT NULL,
    data_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_status_entrega) REFERENCES StatusEntrega(id),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id)
);
