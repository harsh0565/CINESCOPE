import React, { useState } from 'react';
import { useMovie } from '../context/auth'; // Ensure this is correctly imported
import axios from 'axios';

const Movie = () => {
  const [movie, setMovie] = useMovie(); // Get the movie data from context
  const [bgColor, setBgColor] = useState('');
  const handleClick = async () => {
    const t = confirm("do you want to add this to your favourite")

    console.log(movie);
    if (t) {
      const email = localStorage.getItem("email");
      await axios.post("http://localhost:3000/api/v1/addToFavourite", { email, movie }).then((res) => {
        console.log(res);
        setBgColor("danger");
      }).catch((err) => {
        console.error(err);
      })
    }
    else {
      setBgColor("");
    }

  }


  return (
    <div>
      {/* <h1>Movies</h1> */}
      <div className="container-fluid mt-5">
        <div className="container p-5">
          <div className="row">
            <ul className="navbar-nav me-auto">
              <li className="nav-item">

                {Array.isArray(movie) && movie.map((e, index) => (


                  <div className="row mt-4">
                    <div className="col-md-4">
                      <img src={e.Poster} alt="Movie Poster" className="img-fluid" />
                    </div>
                    <div className="col-md-8">
                      <h2>{e.Title} (Movie Duration)</h2>
                      <div className="mb-2">
                        <span>Our Rating: 4.5/5</span>
                        <span className="ml-3">Your Rating: _</span>
                      </div>
                      <button className="btn btn-outline-primary mb-3">Rate & Review</button>
                      <div className="mb-3">
                        <button onClick={handleClick} className={`btn btn-outline-secondary bg-${bgColor}`}>
                          <i className="fas fa-heart"></i> Add to Favourites
                        </button>
                      </div>
                      <div>
                        <p>Description : {e.Plot}</p>
                      </div>
                      <div>
                        <p>Release Date: {e.Released}</p>
                        
                       
                      </div>
                    </div>
                  </div>

                  // <div key={index}>
                  //   <img src={e.Poster} alt="loading" />
                  //   <h3>{e.Title}</h3>
                  //   <button onClick={handleClick} className={`btn bg-${bgColor}`}><i  className="bi bi-heart-fill"></i></button>
                  //   <p>Year: {e.Year}</p>
                  //   <p>Genre: {e.Released}</p>
                  //   <p>Description: {e.Plot}</p>
                  // </div>
                ))}
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};
export default Movie;


