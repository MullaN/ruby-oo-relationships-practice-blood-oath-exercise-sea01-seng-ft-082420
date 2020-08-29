class Follower
    attr_reader :name, :age, :life_motto

    @@all = []

    def initialize(name, age, life_motto)
        @name = name
        @age = age
        @life_motto = life_motto

        @@all << self
    end

    def oaths
        BloodOath.all.select {|oath| oath.follower == self}
    end

    def cults
        self.oaths.map {|oath| oath.cult}
    end

    def join_cult(cult)
        if self.age >= cult.minimum_age
            BloodOath.new(Time.new, cult, self)
        else
            puts "Sorry #{self.name}, you're too young to join #{cult.name}."
        end
    end

    def my_cults_slogans
        cults.map {|cult| cult.slogan}
    end

    def fellow_cult_members
        fellow_cultists = []
        self.cults.each {|cult| fellow_cultists += cult.followers}
        fellow_cultists.select {|follower| follower != self}
    end

    def self.all
        @@all
    end

    def self.of_a_certain_age(age)
        self.all.select {|follower| follower.age == age}
    end

    def self.most_active
        self.all.max_by {|follower| follower.cults.length}
    end

    def self.top_ten
        self.all.sort {|followera, followerb| followera.cults.length <=> followerb.cults.length}.reverse[0..10]
    end
end