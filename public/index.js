/* global Vue, VueRouter, axios */

var TermsPage = {
  template: "#terms-page",
  data: function() {
    return {};
  },
  methods: {},
  computed: {}
};

var FAQPage = {
  template: "#faq-page",
  data: function() {
    return {};
  },
  methods: {},
  computed: {}
};

var AboutPage = {
  template: "#about-page",
  data: function() {
    return {};
  },
  methods: {},
  computed: {}
};

var EventNewPage = {
  template: "#event-new-page",
  data: function() {
    return {
      date: "",
      artist: "",
      venue: "",
      city: "",
      state: "",
      image: "",
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
        image: this.image
      };
      axios.post("/events", params).then(function(response) {
        router.push("/");
      }).catch(function(error) {
        this.errors = error.response.data.errors;
      }.bind(this));
    },
    uploadFile: function(event) {
      if (event.target.files.length > 0) {
        var formData = new FormData();
        formData.append("date", this.date);
        formData.append("artist", this.artist);
        formData.append("venue", this.venue);
        formData.append("city", this.city);
        formData.append("state", this.state);
        formData.append("image", event.target.files[0]);

        axios
          .post("/events", formData)
          .then(function(response) {
            router.push("/");
          }.bind(this));
      }
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
      songs: [],
      artist_id: "",
      event_id: "",
      errors: [],
      currentEvent: {date: "", artist: "", venue: "", city: "", state: "", image: ""},
      currentForum: {comment: ""}
    };
  },
  created: function() {
    axios.get("/events/" + this.$route.params.id).then(function(response) {
      this.event = response.data;
    }.bind(this));
  },
  methods: {
    submitSong: function() {
      var params = {
        title: this.title,
        artist_id: this.event.artists[0].id,
        setlist_id: this.event.setlists[0].id
      };
      axios.post("/songs", params).then(function(response) {
        this.$router.go();
      }.bind(this));
    },
    submitComment: function() {
      var params = {
        user_id: this.user_id,
        event_id: this.event.id,
        comment: this.comment
      };
      axios.post("/forums", params).then(function(response) {
        window.location.reload();
      }.bind(this));
    },
    uploadFile: function(event) {
      if (event.target.files.length > 0) {
        var formData = new FormData();
        formData.append("user_id", this.user_id);
        formData.append("event_id", this.event.id);
        formData.append("comment", this.comment);
        formData.append("image", event.target.files[0]);

        axios
          .post("/forums", formData)
          .then(function(response) {
            console.log(response);
            this.$router.go();
          }.bind(this));
      } 
    },
    setCurrentEvent: function(inputEvent) {
      this.currentEvent = inputEvent;
    },
    updateEvent: function() {
      var params = {
        date: this.currentEvent.date,
        artist: this.currentEvent.artist,
        venue: this.currentEvent.venue,
        city: this.currentEvent.city,
        state: this.currentEvent.state,
        image: this.currentEvent.image
      };
      axios.patch("/events/" + this.currentEvent.id, params).then(function(response) {
        console.log("event updated");
      }).catch(function(error) {
        this.errors = error.response.data.errors;
      }.bind(this));
    },
    deleteSong: function(inputSong) {
      console.log("deleting song");
      axios.delete("/songs/" + inputSong.id).then(function(response) {
        var index = this.event.setlists[0].songs.indexOf(inputSong);
        this.event.setlists[0].songs.splice(index, 1);
        console.log("song deleted");
        router.push("/events/" + this.$route.params.id);
      }.bind(this));
    },
    deleteEvent: function(event) {
      axios.delete("/events/" + event.id).then(function(response) {
        router.push("/");
      }.bind(this));
    },
    deleteComment: function(inputComment) {
      console.log("deleting comment");
      axios.delete("/forums/" + inputComment.id).then(function(response) {
        var index = this.event.forums.indexOf(inputComment);
        this.event.forums.splice(index, 1);
        console.log("comment deleted");
        router.push("/events/" + this.$route.params.id);
      }.bind(this));
    },
    setCurrentForum: function(inputForum) {
      this.currentForum = inputForum;
    },
    editComment: function() {
      var params = {
        user_id: this.currentForum.user_id,
        event_id: this.event.id,
        comment: this.currentForum.comment
      };
      axios.patch("/forums/" + this.currentForum.id, params).then(function(response) {
        console.log("comment updated");
      }).catch(function(error) {
        this.errors = error.response.data.errors;
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
      artist: {},
      sortAttribute: "artists"
    };
  },
  created: function() {
    axios.get("/events").then(function(response) {
      this.events = response.data;
    }.bind(this));
  },
  methods: {
    isValidEvent: function(inputEvent) {
      var validArtist = inputEvent.artists.toLowerCase().includes(this.searchArtist.toLowerCase());
      var validVenue = inputEvent.venue.toLowerCase().includes(this.searchVenue.toLowerCase());
      var validCity = inputEvent.city.toLowerCase().includes(this.searchCity.toLowerCase());
      return validArtist && validVenue && validCity;
    },
    setSortAttribute: function(inputAttribute) {
      this.sortAttribute = inputAttribute;
    }
  },
  computed: {
    sortedEvents: function() {
      return this.events.sort(function(event1, event2) {
        // var event1Artist = event1[this.sortAttribute].toLowerCase();
        // var event2Artist = event2[this.sortAttribute].toLowerCase();
        // return event1Artist.localeCompare(event2Artist);
        // var today = new Date();
        return new Date(event1.date) - new Date(event2.date);
      }.bind(this));
    }
  }
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
    },
    uploadFile: function(event) {
      if (event.target.files.length > 0) {
        var formData = new FormData();
        formData.append("username", this.username);
        formData.append("email", this.email);
        formData.append("password", this.password);
        formData.append("password_confirmation", this.passwordConfirmation);
        formData.append("image", event.target.files[0]);

        axios
          .post("/users", formData)
          .then(function(response) {
            console.log(response);
            router.push("/login");
          }.bind(this));
      }
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
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] = "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
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
    { path: "/events/:id", component: EventShowPage },
    { path: "/about", component: AboutPage },
    { path: "/faq", component: FAQPage },
    { path: "/terms", component: TermsPage }
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
