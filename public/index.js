/* global Vue, VueRouter, axios */

var EventNewPage = {
  template: "#event-new-page",
  data: function() {
    return {
      date: "",
      artist: "",
      venue: "",
      city: "",
      state: "",
      // image: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        date: this.date,
        artist: this.artist,
        venue: this.venue,
        city: this.city,
        state: this.state,
        // image: this.image
      };
      axios.post("/events", params).then(function(response) {
        router.push("/");
      }).catch(function(error) {
        this.errors = error.response.data.errors;
      }.bind(this));
    }
  },
  computed: {}
};

var EventShowPage = {
  template: "#event-show-page",
  data: function() {
    return {
      event: {},
      comment: "",
      title: "",
      forums: {},
      setlists: {},
      songs: {},
      artist_id: ""
    };
  },
  created: function() {
    axios.get("/events/" + this.$route.params.id).then(function(response) {
      this.event = response.data;
      console.log(this);
    }.bind(this));
  },
  methods: {
    submitComment: function() {
      var params = {
        user_id: this.user_id,
        event_id: this.event_id,
        comment: this.comment 
      };
      axios.post("/forums", params).then(function(response) {
        router.push("/events/" + this.$route.params.id);
      }.bind(this));
    },
    submitSong: function() {
      var params = {
        title: this.title,
        artist_id: this.artist_id,
        setlist_id: this.event.setlists[0].id,
        song_id: this.song_id,
        event_id: this.event_id
      };
      axios.post("/songs", params).then(function(response) {
        router.push("/events/" + this.$route.params.id);
      }.bind(this));
    }
  },
  computed: {}
};

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      searchArtist: "",
      searchVenue: "",
      searchCity: "",
      events: [],
      artist: {}
    };
  },
  created: function() {
    axios.get("/events").then(function(response) {
      this.events = response.data;
    }.bind(this));
  },
  methods: {
    isValidEvent: function(inputEvent) {
      // var validArtist = inputEvent.artist.includes(this.searchArtist);
      var validVenue = inputEvent.venue.toLowerCase().includes(this.searchVenue.toLowerCase());
      var validCity = inputEvent.city.toLowerCase().includes(this.searchCity.toLowerCase());
      return validVenue && validCity;
    }
  },
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      username: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        username: this.username,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      console.log("before axios")
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          console.log("above");
          router.push("/");
          console.log("below");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/events/new", component: EventNewPage },
    { path: "/events/:id", component: EventShowPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
