class Tree
    @id = nil
    @children = nil

    # construtor
    def initialize(id, children=[])
        id_type = id.class.to_s
        if id_type != "String" and id_type != "Fixnum" and id_type != "Float"
            puts "ERRO: id = #{id}"
            puts "O id da árvore é sua raiz e só pode ser um número ou uma string (ex.: 'add')"
            return
        end

        @id = id
        @children = children
    end

    # getters
    def children()
        @children
    end

    def id()
        @id
    end
    
    # retorna se a árvore é uma folha ou não
    def leaf?()
        @children.length == 0
    end

    # insere um filho na árvore
    def insert(item)
        # TODO: filtrar isso aqui um pouco talvez
        @children << item
    end

    # representação simples da árvore, para facilitar debug e visualização
    def inspect()
        "<#{@id}, #{@children}>"
    end

    def to_s
        inspect()
    end

    # função que retorna uma deepcopy da árvore
    # (e recursivamente cria deepcopies das árvores filhas dela também)
    def deepcopy()
        copy = Tree.new(self.id())

        for child in self.children() do
            if child.is_a?(Tree)
                copy.insert(child.deepcopy())

            else
                copy.insert(child)
            end
        end

        copy
    end

end


t = Tree.new("add", [1, 2])
t1 = Tree.new(1.2, [1, 2])
t2 = Tree.new(Tree.new(1))