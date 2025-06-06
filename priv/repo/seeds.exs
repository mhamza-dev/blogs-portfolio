# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogsPortfolio.Repo.insert!(%BlogsPortfolio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BlogsPortfolio.Backoffice.Admin
alias BlogsPortfolio.Content.{HeroContent, BlogPost}
alias BlogsPortfolio.Repo

# Create admin user
admin_attrs = %{
  email: "admin@example.com",
  password: "admin123456789",
  confirmed_at: DateTime.utc_now() |> DateTime.truncate(:second)
}

blogs = [
  %{
    title: "Phoenix LiveView Tutorial: Getting Started",
    body: """
    <h2>Phoenix LiveView Tutorial: Getting Started</h2>
    <p><strong>Author:</strong> Nimrod Kramer</p>
    <p><strong>Published:</strong> August 1, 2024</p>
    <p>Learn how to build interactive, real-time web applications with Phoenix LiveView using Elixir and Phoenix. Get started with key components, core concepts, best practices, and tips for better LiveView apps.</p>
    <p><a href="https://daily.dev/blog/phoenix-liveview-tutorial-getting-started">Read more</a></p>
    """
  },
  %{
    title: "Elixir Phoenix Framework — Tutorial To Build a Blog in 15 Minutes",
    body: """
    <h2>Elixir Phoenix Framework — Tutorial To Build a Blog in 15 Minutes</h2>
    <p><strong>Author:</strong> Jakub Cieślar</p>
    <p>Step-by-step tutorial on creating a blog application using Elixir and Phoenix in just 15 minutes.</p>
    <p><a href="https://www.monterail.com/blog/elixir-phoenix-framework-tutorial">Read more</a></p>
    """
  },
  %{
    title: "Phoenix LiveView Tutorial - Build Interactive Live Chat Application from Scratch",
    body: """
    <h2>Phoenix LiveView Tutorial - Build Interactive Live Chat Application from Scratch</h2>
    <p><strong>Author:</strong> Michał Buszkiewicz</p>
    <p><strong>Published:</strong> May 20, 2025</p>
    <p>A comprehensive guide to building a messenger-like live chat application using Phoenix LiveView.</p>
    <p><a href="https://curiosum.com/blog/phoenix-live-view-tutorial">Read more</a></p>
    """
  },
  %{
    title: "Tutorial to Build a Blog Platform with Elixir Phoenix and Next.js",
    body: """
    <h2>Tutorial to Build a Blog Platform with Elixir Phoenix and Next.js</h2>
    <p><strong>Author:</strong> Tan Loi</p>
    <p>A tutorial on developing a web application from scratch using Elixir Phoenix for the backend and Next.js for the frontend.</p>
    <p><a href="https://medium.com/@tanloiit2010/tutorial-to-build-a-blog-platform-with-elixir-phoenix-and-next-js-a94f18836c7">Read more</a></p>
    """
  },
  %{
    title: "Phoenix Blog Post: Roll Your Own Blog in Elixir and Phoenix",
    body: """
    <h2>Phoenix Blog Post: Roll Your Own Blog in Elixir and Phoenix</h2>
    <p><strong>Author:</strong> ragamuf</p>
    <p><strong>Published:</strong> September 3, 2022</p>
    <p>A guide on creating a blog in Elixir and Phoenix that uses Markdown and supports native comments.</p>
    <p><a href="https://elixirforum.com/t/phoenix-blog-post-roll-your-own-blog-in-elixir-and-phoenix/49966">Read more</a></p>
    """
  },
  %{
    title: "Getting Started with Phoenix LiveView - The Pragmatic Studio",
    body: """
    <h2>Getting Started with Phoenix LiveView - The Pragmatic Studio</h2>
    <p><strong>Author:</strong> Mike Clark</p>
    <p><strong>Published:</strong> February 9, 2023</p>
    <p>A beginner-friendly tutorial on building a basic LiveView from scratch to understand user event handling.</p>
    <p><a href="https://pragmaticstudio.com/tutorials/getting-started-with-phoenix-liveview">Read more</a></p>
    """
  },
  %{
    title: "Building a Blog Engine with Elixir and Phoenix",
    body: """
    <h2>Building a Blog Engine with Elixir and Phoenix</h2>
    <p>A step-by-step guide on building a robust blog engine using Elixir and the Phoenix framework.</p>
    <p><a href="https://clouddevs.com/elixir/blog-engine-with-elixir-and-phoenix/">Read more</a></p>
    """
  },
  %{
    title: "(Unofficial) Getting Started with Elixir Phoenix Guide",
    body: """
    <h2>(Unofficial) Getting Started with Elixir Phoenix Guide</h2>
    <p><strong>Author:</strong> Andy Klimczak</p>
    <p>A beginner-friendly guide designed for those new to creating Phoenix applications from scratch.</p>
    <p><a href="https://dev.to/andyklimczak/very-unofficial-getting-started-with-elixir-phoenix-guide-3k55">Read more</a></p>
    """
  },
  %{
    title: "Walk-Through of Phoenix LiveView | Blog - Elixir School",
    body: """
    <h2>Walk-Through of Phoenix LiveView | Blog - Elixir School</h2>
    <p><strong>Author:</strong> Sophie DeBenedetto</p>
    <p><strong>Published:</strong> March 19, 2019</p>
    <p>An insightful walk-through on using Phoenix LiveView for real-time features without complex JavaScript frameworks.</p>
    <p><a href="https://elixirschool.com/blog/phoenix-live-view">Read more</a></p>
    """
  },
  %{
    title: "Phoenix LiveView 1.0.0 is Here!",
    body: """
    <h2>Phoenix LiveView 1.0.0 is Here!</h2>
    <p><strong>Author:</strong> Chris McCord</p>
    <p>An announcement and overview of the features introduced in Phoenix LiveView 1.0.0.</p>
    <p><a href="https://www.phoenixframework.org/blog/phoenix-liveview-1.0-released">Read more</a></p>
    """
  }
]

hero_content = %{
  title: "Muhammad Hamza",
  bio: """
  <h1>Passionate Full-Stack Developer</h1>
  <p>I'm <strong>Muhammad Hamza</strong>, a dedicated software engineer with a love for clean architecture and scalable systems.</p>
  <p>My journey began with the <strong>MERN stack</strong>—building robust REST and GraphQL APIs using Node.js and Express, paired with MongoDB and React for modern, responsive interfaces.</p>
  <p>Over time, I transitioned into the world of functional programming and fell in love with <strong>Elixir and Phoenix</strong>. Today, I build high-performance, real-time web apps using <strong>Phoenix LiveView</strong>, leveraging the power of OTP and fault-tolerant systems.</p>
  <p>Mobile development is also part of my toolkit—with <strong>React Native</strong>, I deliver beautiful, cross-platform mobile experiences with native feel.</p>
  <p>From scalable backend services to slick UIs and mobile apps, I enjoy solving real-world problems with elegant code and intuitive user experiences.</p>
  <p>📫 Let's connect below:</p>
  """,
  social_links: [
    %{type: :github, icon: "github", url: "https://github.com/mhamza-dev"},
    %{type: :linkedin, icon: "linkedin", url: "https://linkedin.com/in/mhamza-dev"},
    %{type: :x, icon: "x-twitter", url: "https://x.com/mhamza_dev"},
    %{type: :facebook, icon: "facebook", url: "https://facebook.com/mhamza.dev"},
    %{type: :youtube, icon: "youtube", url: "https://youtube.com/@mhamzadev"},
    %{type: :instagram, icon: "instagram", url: "https://instagram.com/mhamza.dev"},
    %{
      type: :stack_overflow,
      icon: "stack-overflow",
      url: "https://stackoverflow.com/users/1234567/mhamza-dev"
    },
    %{type: :thread, icon: "threads", url: "https://threads.net/@mhamza.dev"},
    %{type: :devto, icon: "dev-to", url: "https://dev.to/mhamzadev"}
  ]
}

%Admin{}
|> Admin.registration_changeset(admin_attrs)
|> Repo.insert!()

Enum.each(blogs, fn blog ->
  %BlogPost{}
  |> BlogPost.changeset(blog)
  |> Repo.insert!()
end)

%HeroContent{}
|> HeroContent.changeset(hero_content)
|> Repo.insert!()
